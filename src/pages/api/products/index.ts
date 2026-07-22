import type { APIRoute } from 'astro';
import { env } from 'cloudflare:workers';

export const prerender = false;

export const GET: APIRoute = async ({ url }) => {
  try {
    const db = env.DB;
    if (!db) {
      return new Response(JSON.stringify({ error: 'Database not available' }), {
        status: 500,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    const series = url.searchParams.get('series');
    const category = url.searchParams.get('category');
    const search = url.searchParams.get('q');

    let query = 'SELECT * FROM products WHERE 1=1';
    const bindings: any[] = [];

    if (series) {
      query += ' AND series = ?';
      bindings.push(series);
    }
    if (category) {
      query += ' AND category = ?';
      bindings.push(category);
    }
    if (search) {
      query += ' AND (name LIKE ? OR description LIKE ? OR oem LIKE ?)';
      const s = `%${search}%`;
      bindings.push(s, s, s);
    }

    query += ' ORDER BY id';

    const result = await db.prepare(query).bind(...bindings).all();

    return new Response(JSON.stringify(result.results), {
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    console.error('Products API error:', error);
    return new Response(JSON.stringify({ error: 'Failed to fetch products' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });
  }
};
