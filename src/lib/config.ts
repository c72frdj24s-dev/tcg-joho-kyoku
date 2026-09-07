import env from '@/env';

export const config = {
  app: {
    name: env.NEXT_PUBLIC_APP_NAME,
    url: env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000',
    description: 'トレーディングカードの販売・抽選・店舗情報共有アプリ',
  },
  supabase: {
    url: env.NEXT_PUBLIC_SUPABASE_URL,
    anonKey: env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
  },
  pagination: {
    defaultLimit: 20,
    maxLimit: 100,
  },
  storage: {
    buckets: {
      productImages: 'product-images',
      storeImages: 'store-images',
      userAvatars: 'user-avatars',
      submissions: 'submissions',
    },
    maxFileSize: 5 * 1024 * 1024, // 5MB
  },
  cache: {
    defaultRevalidate: 60, // seconds
    productList: 300,
    productDetail: 600,
    storeList: 300,
    saleList: 60,
    lotteryList: 60,
  },
} as const;
