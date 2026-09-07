'use client';

import { useEffect, useState } from 'react';
import ProductCard from '@/components/cards/ProductCard';
import { createClient } from '@/lib/supabase/client';
import { Database } from '@/lib/types/database';
import { Loader } from 'lucide-react';

type Product = Database['public']['Tables']['products']['Row'];

export default function HomePage() {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);
  const supabase = createClient();

  useEffect(() => {
    const fetchProducts = async () => {
      const { data, error } = await supabase
        .from('products')
        .select('*')
        .eq('is_published', true)
        .limit(10);
      
      if (!error) {
        setProducts(data || []);
      }
      setLoading(false);
    };

    fetchProducts();
  }, []);

  return (
    <div className="container-safe">
      <div className="space-y-6">
        {/* Header Section */}
        <section className="space-y-4">
          <h1 className="text-3xl font-bold">TCG情報局</h1>
          <p className="text-gray-600 dark:text-gray-400">
            トレーディングカードの最新情報をお届けします
          </p>
        </section>

        {/* Hot News Section */}
        <section>
          <h2 className="text-xl font-semibold mb-4">🔥 注目情報</h2>
          {loading ? (
            <div className="flex justify-center py-8">
              <Loader className="animate-spin" />
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {products.slice(0, 4).map((product) => (
                <ProductCard key={product.id} product={product} />
              ))}
            </div>
          )}
        </section>

        {/* Latest News Section */}
        <section>
          <h2 className="text-xl font-semibold mb-4">🆕 最新情報</h2>
          {loading ? (
            <div className="flex justify-center py-8">
              <Loader className="animate-spin" />
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {products.slice(4, 8).map((product) => (
                <ProductCard key={product.id} product={product} />
              ))}
            </div>
          )}
        </section>

        {/* Categories Section */}
        <section>
          <h2 className="text-xl font-semibold mb-4">📂 カテゴリー</h2>
          <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
            {['ポケモンカード', 'ワンピースカード', '遊戯王', 'デュエル・マスターズ', 'ドラゴンボール', 'その他'].map((category) => (
              <button
                key={category}
                className="p-4 bg-white dark:bg-dark-surface rounded-lg text-center hover:bg-gray-100 dark:hover:bg-dark-surface/50 transition-colors"
              >
                <p className="font-semibold text-sm">{category}</p>
              </button>
            ))}
          </div>
        </section>
      </div>
    </div>
  );
}
