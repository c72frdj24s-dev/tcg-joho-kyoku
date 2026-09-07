'use client';

import Header from '@/components/layout/Header';
import BottomNavigation from '@/components/layout/BottomNavigation';
import { ReactNode } from 'react';

export default function PublicLayout({ children }: { children: ReactNode }) {
  return (
    <>
      <Header />
      <main className="pb-20">
        {children}
      </main>
      <BottomNavigation />
    </>
  );
}
