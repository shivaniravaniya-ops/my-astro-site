import type { APIRoute } from 'astro';
import { env } from 'cloudflare:workers';

export const prerender = false;

export const POST: APIRoute = async ({ request }) => {
  try {
    const body = await request.json();
    const { email, password, firstName, lastName } = body;

    if (!email || !password || !firstName || !lastName) {
      return new Response(JSON.stringify({ error: 'All fields are required' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    if (password.length < 8) {
      return new Response(JSON.stringify({ error: 'Password must be at least 8 characters' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    const db = env.DB;
    if (!db) {
      return new Response(JSON.stringify({ error: 'Database not available' }), {
        status: 500,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    // Check if user already exists
    const existing = await db.prepare('SELECT id FROM users WHERE email = ?').bind(email).first();
    if (existing) {
      return new Response(JSON.stringify({ error: 'Email already registered' }), {
        status: 409,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    // Hash password (simple hash for demo - use bcrypt in production)
    const encoder = new TextEncoder();
    const data = encoder.encode(password + email);
    const hashBuffer = await crypto.subtle.digest('SHA-256', data);
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    const passwordHash = hashArray.map(b => b.toString(16).padStart(2, '0')).join('');

    // Insert new user
    const result = await db.prepare(
      'INSERT INTO users (email, password_hash, first_name, last_name) VALUES (?, ?, ?, ?)'
    ).bind(email, passwordHash, firstName, lastName).run();

    const userId = result.meta?.last_row_id;

    // Create session token
    const sessionData = JSON.stringify({ userId, email, firstName, lastName });
    const sessionEncoder = new TextEncoder();
    const sessionBuffer = await crypto.subtle.digest('SHA-256', sessionEncoder.encode(sessionData + Date.now()));
    const sessionArray = Array.from(new Uint8Array(sessionBuffer));
    const sessionToken = sessionArray.map(b => b.toString(16).padStart(2, '0')).join('');

    return new Response(JSON.stringify({
      success: true,
      user: { id: userId, email, firstName, lastName },
      token: sessionToken
    }), {
      status: 201,
      headers: { 'Content-Type': 'application/json' }
    });

  } catch (error) {
    console.error('Register error:', error);
    return new Response(JSON.stringify({ error: 'Registration failed' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });
  }
};
