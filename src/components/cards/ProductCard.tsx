'use client';

import Link from 'next/link';
import { Database } from '@/lib/types/database';
import { Heart } from 'lucide-react';
import { formatDate } from '@/lib/utils/formatting';

type Product = Database['public']['Tables']['products']['Row'];

interface ProductCardProps {
  product: Product;
}

export default function ProductCard({ product }: ProductCardProps) {
  return (
    <Link href={`/products/${product.id}`}>
      <div className="card hover:shadow-lg transition-shadow cursor-pointer">
        {product.image_url && (
          <div className="relative w-full h-48 mb-3 bg-gray-200 dark:bg-gray-700 rounded-lg overflow-hidden">
            {/* Image placeholder */}
            <div className="w-full h-full flex items-center justify-center text-gray-400">
              画像
            </div>
          </div>
        )}
        
        <div className="space-y-2">
          <h3 className="font-semibold line-clamp-2">{product.name}</h3>
          
          {product.series && (
            <p className="text-sm text-gray-600 dark:text-gray-400">{product.series}</p>
          )}
          
          {product.regular_price && (
            <p className="text-lg font-bold text-blue-600">
              ¥{product.regular_price.toLocaleString('ja-JP')}
            </p>
          )}
          
          {product.release_date && (
            <p className="text-xs text-gray-500">
              発売: {formatDate(product.release_date)}
            </p>
          )}
          
          <button className="mt-3 flex items-center gap-2 text-gray-600 hover:text-red-600 transition-colors">
            <Heart size={18} />
            <span className="text-sm">お気に入り</span>
          </button>
        </div>
      </div>
    </Link>
  );
}
