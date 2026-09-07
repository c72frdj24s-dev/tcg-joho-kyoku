// Enums for the application

export enum UserRole {
  OWNER = 'OWNER',
  ADMIN = 'ADMIN',
  EDITOR = 'EDITOR',
  MODERATOR = 'MODERATOR',
  CONTRIBUTOR = 'CONTRIBUTOR',
  USER = 'USER',
}

export enum Permission {
  VIEW_DASHBOARD = 'view_dashboard',
  MANAGE_PRODUCTS = 'manage_products',
  MANAGE_SALES = 'manage_sales',
  MANAGE_LOTTERIES = 'manage_lotteries',
  MANAGE_STORES = 'manage_stores',
  MANAGE_USERS = 'manage_users',
  MANAGE_ROLES = 'manage_roles',
  MANAGE_SUBMISSIONS = 'manage_submissions',
  MANAGE_REPORTS = 'manage_reports',
  MANAGE_X_POSTS = 'manage_x_posts',
  MANAGE_NOTIFICATIONS = 'manage_notifications',
  MANAGE_SETTINGS = 'manage_settings',
  VIEW_SUBMISSIONS = 'view_submissions',
  CREATE_SUBMISSION = 'create_submission',
  CREATE_REPORT = 'create_report',
}

export enum SaleType {
  IN_STORE = 'in_store',
  ONLINE = 'online',
  FIRST_COME = 'first_come',
  OTHER = 'other',
}

export enum SaleStatus {
  ONGOING = 'ongoing',
  UPCOMING = 'upcoming',
  ENDED = 'ended',
}

export enum LotteryStatus {
  ACCEPTING = 'accepting',
  NOT_STARTED = 'not_started',
  ENDED = 'ended',
}

export enum SubmissionStatus {
  PENDING = 'pending',
  APPROVED = 'approved',
  REJECTED = 'rejected',
}

export enum ReportStatus {
  PENDING = 'pending',
  REVIEWING = 'reviewing',
  RESOLVED = 'resolved',
  REJECTED = 'rejected',
}

export enum NotificationType {
  SALE_ADDED = 'sale_added',
  SALE_UPDATED = 'sale_updated',
  LOTTERY_ADDED = 'lottery_added',
  LOTTERY_UPDATED = 'lottery_updated',
  PRODUCT_ADDED = 'product_added',
  ANNOUNCEMENT = 'announcement',
}
