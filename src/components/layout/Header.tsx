'use client';

import Link from 'next/link';
import { Bell, Search, User } from 'lucide-react';

export default function Header() {
  return (
    <header className="sticky top-0 z-40 bg-white dark:bg-dark-surface border-b border-gray-200 dark:border-gray-700">
      <div className="container-safe flex items-center justify-between">
        <Link href="/" className="text-2xl font-bold text-blue-600">
          TCG情報局
        </Link>
        
        <div className="flex items-center gap-3">
          <button className="p-2 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg">
            <Search size={20} />
          </button>
          <button className="p-2 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg">
            <Bell size={20} />
          </button>
          <Link href="/auth/login" className="p-2 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg">
            <User size={20} />
          </Link>
        </div>
      </div>
    </header>
  );
}
