// Database types

export type Database = {
  public: {
    Tables: {
      profiles: {
        Row: {
          id: string;
          username: string | null;
          display_name: string | null;
          avatar_url: string | null;
          bio: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id: string;
          username?: string | null;
          display_name?: string | null;
          avatar_url?: string | null;
          bio?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          username?: string | null;
          display_name?: string | null;
          avatar_url?: string | null;
          bio?: string | null;
          created_at?: string;
          updated_at?: string;
        };
      };
      roles: {
        Row: {
          id: string;
          name: string;
          description: string | null;
          created_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          description?: string | null;
          created_at?: string;
        };
        Update: {
          id?: string;
          name?: string;
          description?: string | null;
          created_at?: string;
        };
      };
      user_roles: {
        Row: {
          id: string;
          user_id: string;
          role_id: string;
          created_at: string;
        };
        Insert: {
          id?: string;
          user_id: string;
          role_id: string;
          created_at?: string;
        };
        Update: {
          id?: string;
          user_id?: string;
          role_id?: string;
          created_at?: string;
        };
      };
      categories: {
        Row: {
          id: string;
          name: string;
          description: string | null;
          icon: string | null;
          color: string | null;
          order: number;
          is_published: boolean;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          description?: string | null;
          icon?: string | null;
          color?: string | null;
          order?: number;
          is_published?: boolean;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          name?: string;
          description?: string | null;
          icon?: string | null;
          color?: string | null;
          order?: number;
          is_published?: boolean;
          created_at?: string;
          updated_at?: string;
        };
      };
      products: {
        Row: {
          id: string;
          name: string;
          image_url: string | null;
          category_id: string;
          series: string | null;
          release_date: string | null;
          regular_price: number | null;
          description: string | null;
          jan_code: string | null;
          is_featured: boolean;
          is_published: boolean;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          image_url?: string | null;
          category_id: string;
          series?: string | null;
          release_date?: string | null;
          regular_price?: number | null;
          description?: string | null;
          jan_code?: string | null;
          is_featured?: boolean;
          is_published?: boolean;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          name?: string;
          image_url?: string | null;
          category_id?: string;
          series?: string | null;
          release_date?: string | null;
          regular_price?: number | null;
          description?: string | null;
          jan_code?: string | null;
          is_featured?: boolean;
          is_published?: boolean;
          created_at?: string;
          updated_at?: string;
        };
      };
      product_favorites: {
        Row: {
          id: string;
          user_id: string;
          product_id: string;
          created_at: string;
        };
        Insert: {
          id?: string;
          user_id: string;
          product_id: string;
          created_at?: string;
        };
        Update: {
          id?: string;
          user_id?: string;
          product_id?: string;
          created_at?: string;
        };
      };
      stores: {
        Row: {
          id: string;
          name: string;
          prefecture: string;
          city: string;
          address: string;
          latitude: number;
          longitude: number;
          phone: string | null;
          opening_hours: string | null;
          website_url: string | null;
          description: string | null;
          image_url: string | null;
          is_published: boolean;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          name: string;
          prefecture: string;
          city: string;
          address: string;
          latitude: number;
          longitude: number;
          phone?: string | null;
          opening_hours?: string | null;
          website_url?: string | null;
          description?: string | null;
          image_url?: string | null;
          is_published?: boolean;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          name?: string;
          prefecture?: string;
          city?: string;
          address?: string;
          latitude?: number;
          longitude?: number;
          phone?: string | null;
          opening_hours?: string | null;
          website_url?: string | null;
          description?: string | null;
          image_url?: string | null;
          is_published?: boolean;
          created_at?: string;
          updated_at?: string;
        };
      };
    };
  };
};
