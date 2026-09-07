import { createBrowserClient } from '@supabase/auth-helpers-nextjs';
import env from '@/env';
import type { Database } from '@/lib/types/database';

export function createClient() {
  return createBrowserClient<Database>(
    env.NEXT_PUBLIC_SUPABASE_URL,
    env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  );
}
