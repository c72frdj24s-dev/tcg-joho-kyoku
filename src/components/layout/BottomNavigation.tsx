'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { Home, Info, Trophy, Map, User } from 'lucide-react';

const navItems = [
  { href: '/', icon: Home, label: 'ホーム' },
  { href: '/products', icon: Info, label: '情報' },
  { href: '/lotteries', icon: Trophy, label: '抽選' },
  { href: '/map', icon: Map, label: 'マップ' },
  { href: '/mypage', icon: User, label: 'マイページ' },
];

export default function BottomNavigation() {
  const pathname = usePathname();

  return (
    <nav className="fixed bottom-0 left-0 right-0 bg-white dark:bg-dark-surface border-t border-gray-200 dark:border-gray-700 safe-area-bottom">
      <div className="flex items-center justify-around">
        {navItems.map((item) => {
          const Icon = item.icon;
          const isActive = pathname === item.href;
          
          return (
            <Link
              key={item.href}
              href={item.href}
              className={`flex-1 flex flex-col items-center justify-center py-3 gap-1 transition-colors ${
                isActive
                  ? 'text-blue-600 dark:text-blue-400'
                  : 'text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-gray-200'
              }`}
            >
              <Icon size={24} />
              <span className="text-xs">{item.label}</span>
            </Link>
          );
        })}
      </div>
    </nav>
  );
}
