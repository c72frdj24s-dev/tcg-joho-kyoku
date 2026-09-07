-- ========================================
-- TCG情報局 - Database Initial Migration
-- ========================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ========================================
-- 1. ROLES & PERMISSIONS
-- ========================================

CREATE TABLE roles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(50) UNIQUE NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE permissions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(50) UNIQUE NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE role_permissions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  role_id UUID NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
  permission_id UUID NOT NULL REFERENCES permissions(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(role_id, permission_id)
);

-- ========================================
-- 2. USERS & PROFILES
-- ========================================

CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username VARCHAR(255) UNIQUE,
  display_name VARCHAR(255),
  avatar_url TEXT,
  bio TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE user_roles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  role_id UUID NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, role_id)
);

-- ========================================
-- 3. CATEGORIES
-- ========================================

CREATE TABLE categories (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  icon VARCHAR(255),
  color VARCHAR(7),
  "order" INTEGER DEFAULT 0,
  is_published BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ========================================
-- 4. PRODUCTS
-- ========================================

CREATE TABLE products (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  image_url TEXT,
  category_id UUID NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,
  series VARCHAR(255),
  release_date DATE,
  regular_price INTEGER,
  description TEXT,
  jan_code VARCHAR(13),
  is_featured BOOLEAN DEFAULT FALSE,
  is_published BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_products_category_id ON products(category_id);
CREATE INDEX idx_products_is_published ON products(is_published);
CREATE INDEX idx_products_is_featured ON products(is_featured);
CREATE INDEX idx_products_created_at ON products(created_at DESC);

CREATE TABLE product_favorites (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, product_id)
);

CREATE INDEX idx_product_favorites_user_id ON product_favorites(user_id);
CREATE INDEX idx_product_favorites_product_id ON product_favorites(product_id);

-- ========================================
-- 5. STORES
-- ========================================

CREATE TABLE stores (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  prefecture VARCHAR(50) NOT NULL,
  city VARCHAR(255) NOT NULL,
  address TEXT NOT NULL,
  latitude DECIMAL(10, 8) NOT NULL,
  longitude DECIMAL(11, 8) NOT NULL,
  phone VARCHAR(20),
  opening_hours TEXT,
  website_url TEXT,
  description TEXT,
  image_url TEXT,
  is_published BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_stores_prefecture ON stores(prefecture);
CREATE INDEX idx_stores_city ON stores(city);
CREATE INDEX idx_stores_is_published ON stores(is_published);

CREATE TABLE store_favorites (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  store_id UUID NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, store_id)
);

CREATE INDEX idx_store_favorites_user_id ON store_favorites(user_id);

-- ========================================
-- 6. SALES
-- ========================================

CREATE TABLE sales (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  store_id UUID NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  sale_type VARCHAR(50) NOT NULL DEFAULT 'other',
  start_at TIMESTAMP WITH TIME ZONE NOT NULL,
  end_at TIMESTAMP WITH TIME ZONE NOT NULL,
  price INTEGER,
  stock_info TEXT,
  url TEXT,
  notes TEXT,
  is_published BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_sales_product_id ON sales(product_id);
CREATE INDEX idx_sales_store_id ON sales(store_id);
CREATE INDEX idx_sales_start_at ON sales(start_at);
CREATE INDEX idx_sales_end_at ON sales(end_at);
CREATE INDEX idx_sales_is_published ON sales(is_published);

-- ========================================
-- 7. LOTTERIES
-- ========================================

CREATE TABLE lotteries (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  store_id UUID NOT NULL REFERENCES stores(id) ON DELETE CASCADE,
  entry_start_at TIMESTAMP WITH TIME ZONE NOT NULL,
  entry_end_at TIMESTAMP WITH TIME ZONE NOT NULL,
  announcement_at TIMESTAMP WITH TIME ZONE,
  pickup_start_at TIMESTAMP WITH TIME ZONE,
  pickup_end_at TIMESTAMP WITH TIME ZONE,
  entry_conditions TEXT,
  url TEXT,
  notes TEXT,
  is_published BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_lotteries_product_id ON lotteries(product_id);
CREATE INDEX idx_lotteries_store_id ON lotteries(store_id);
CREATE INDEX idx_lotteries_entry_start_at ON lotteries(entry_start_at);
CREATE INDEX idx_lotteries_entry_end_at ON lotteries(entry_end_at);
CREATE INDEX idx_lotteries_is_published ON lotteries(is_published);

-- ========================================
-- 8. NOTIFICATIONS
-- ========================================

CREATE TABLE notifications (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  type VARCHAR(50) NOT NULL,
  title VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  related_product_id UUID REFERENCES products(id) ON DELETE SET NULL,
  related_store_id UUID REFERENCES stores(id) ON DELETE SET NULL,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_is_read ON notifications(is_read);
CREATE INDEX idx_notifications_created_at ON notifications(created_at DESC);

-- ========================================
-- 9. SUBMISSIONS
-- ========================================

CREATE TABLE submissions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  product_name VARCHAR(255),
  store_id UUID REFERENCES stores(id) ON DELETE SET NULL,
  submission_type VARCHAR(50) NOT NULL,
  content TEXT NOT NULL,
  url TEXT,
  image_url TEXT,
  submitted_at TIMESTAMP WITH TIME ZONE NOT NULL,
  status VARCHAR(50) DEFAULT 'pending',
  rejection_reason TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_submissions_user_id ON submissions(user_id);
CREATE INDEX idx_submissions_status ON submissions(status);
CREATE INDEX idx_submissions_created_at ON submissions(created_at DESC);

-- ========================================
-- 10. REPORTS
-- ========================================

CREATE TABLE reports (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  target_type VARCHAR(50) NOT NULL,
  target_id UUID NOT NULL,
  reason VARCHAR(50) NOT NULL,
  description TEXT,
  status VARCHAR(50) DEFAULT 'pending',
  reviewed_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  review_notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_reports_user_id ON reports(user_id);
CREATE INDEX idx_reports_status ON reports(status);
CREATE INDEX idx_reports_target_type ON reports(target_type);
CREATE INDEX idx_reports_created_at ON reports(created_at DESC);

-- ========================================
-- 11. X POSTS
-- ========================================

CREATE TABLE x_posts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  post_url TEXT NOT NULL,
  post_content TEXT NOT NULL,
  author_name VARCHAR(255),
  posted_at TIMESTAMP WITH TIME ZONE,
  related_product_id UUID REFERENCES products(id) ON DELETE SET NULL,
  related_store_id UUID REFERENCES stores(id) ON DELETE SET NULL,
  is_published BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_x_posts_is_published ON x_posts(is_published);
CREATE INDEX idx_x_posts_created_at ON x_posts(created_at DESC);

-- ========================================
-- 12. COMMENTS
-- ========================================

CREATE TABLE comments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  target_type VARCHAR(50) NOT NULL,
  target_id UUID NOT NULL,
  content TEXT NOT NULL,
  is_deleted BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_comments_user_id ON comments(user_id);
CREATE INDEX idx_comments_target_type ON comments(target_type);
CREATE INDEX idx_comments_target_id ON comments(target_id);

-- ========================================
-- 13. AUDIT LOGS
-- ========================================

CREATE TABLE audit_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE SET NULL,
  action VARCHAR(100) NOT NULL,
  target_type VARCHAR(50),
  target_id UUID,
  metadata JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_audit_logs_user_id ON audit_logs(user_id);
CREATE INDEX idx_audit_logs_created_at ON audit_logs(created_at DESC);

-- ========================================
-- 14. SITE SETTINGS
-- ========================================

CREATE TABLE site_settings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  key VARCHAR(255) UNIQUE NOT NULL,
  value JSONB NOT NULL,
  description TEXT,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ========================================
-- ROW LEVEL SECURITY (RLS)
-- ========================================

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE store_favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE submissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_logs ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public profiles are viewable" ON profiles FOR SELECT USING (true);
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can insert own profile" ON profiles FOR INSERT WITH CHECK (auth.uid() = id);

CREATE POLICY "Users view own favorites" ON product_favorites FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users create own favorites" ON product_favorites FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users delete own favorites" ON product_favorites FOR DELETE USING (auth.uid() = user_id);

CREATE POLICY "Users view own store favorites" ON store_favorites FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users create own store favorites" ON store_favorites FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users delete own store favorites" ON store_favorites FOR DELETE USING (auth.uid() = user_id);

CREATE POLICY "Users view own notifications" ON notifications FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users update own notifications" ON notifications FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users view own submissions" ON submissions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users create submissions" ON submissions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Approved submissions visible" ON submissions FOR SELECT USING (status = 'approved');

CREATE POLICY "Users view own reports" ON reports FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users create reports" ON reports FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users view own audit logs" ON audit_logs FOR SELECT USING (auth.uid() = user_id);

-- ========================================
-- FUNCTIONS & TRIGGERS
-- ========================================

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_products_updated_at BEFORE UPDATE ON products FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_stores_updated_at BEFORE UPDATE ON stores FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_sales_updated_at BEFORE UPDATE ON sales FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_lotteries_updated_at BEFORE UPDATE ON lotteries FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_submissions_updated_at BEFORE UPDATE ON submissions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_reports_updated_at BEFORE UPDATE ON reports FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_x_posts_updated_at BEFORE UPDATE ON x_posts FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_comments_updated_at BEFORE UPDATE ON comments FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE OR REPLACE FUNCTION public.handle_new_user() RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, display_name, avatar_url)
  VALUES (new.id, new.raw_user_meta_data->>'display_name', new.raw_user_meta_data->>'avatar_url');
  INSERT INTO public.user_roles (user_id, role_id)
  SELECT new.id, id FROM roles WHERE name = 'USER' ON CONFLICT DO NOTHING;
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ========================================
-- SEED DATA
-- ========================================

INSERT INTO roles (name, description) VALUES
  ('OWNER', '最高権限ロール'),
  ('ADMIN', 'システム管理者ロール'),
  ('EDITOR', 'コンテンツ編集者ロール'),
  ('MODERATOR', 'モデレーターロール'),
  ('CONTRIBUTOR', '情報提供者ロール'),
  ('USER', '一般ユーザーロール')
ON CONFLICT DO NOTHING;

INSERT INTO permissions (name, description) VALUES
  ('view_dashboard', 'ダッシュボード表示'),
  ('manage_products', '商品管理'),
  ('manage_sales', '販売情報管理'),
  ('manage_lotteries', '抽選情報管理'),
  ('manage_stores', '店舗管理'),
  ('manage_users', 'ユーザー管理'),
  ('manage_roles', 'ロール管理'),
  ('manage_submissions', '情報提供管理'),
  ('manage_reports', '通報管理'),
  ('manage_x_posts', 'X情報管理'),
  ('manage_notifications', '通知管理'),
  ('manage_settings', '設定管理'),
  ('view_submissions', '情報提供閲覧'),
  ('create_submission', '情報提供作成'),
  ('create_report', '通報作成')
ON CONFLICT DO NOTHING;

INSERT INTO categories (name, description, icon, color, "order", is_published) VALUES
  ('ポケモンカード', 'ポケモンのトレーディングカード', '⭐', '#FFD700', 1, true),
  ('ワンピースカード', 'ワンピースのトレーディングカード', '⚓', '#FF6B6B', 2, true),
  ('遊戯王', '遊戯王のトレーディングカード', '🃏', '#4169E1', 3, true),
  ('デュエル・マスターズ', 'デュエル・マスターズのトレーディングカード', '⚡', '#FF8C00', 4, true),
  ('ドラゴンボール', 'ドラゴンボールのトレーディングカード', '🐉', '#FF6347', 5, true),
  ('その他', 'その他のトレーディングカード', '📦', '#808080', 6, true)
ON CONFLICT DO NOTHING;
