import { format } from 'date-fns';
import { ja } from 'date-fns/locale';

export function formatDate(date: string | Date): string {
  const d = typeof date === 'string' ? new Date(date) : date;
  return format(d, 'yyyy年MM月dd日', { locale: ja });
}

export function formatDateTime(date: string | Date): string {
  const d = typeof date === 'string' ? new Date(date) : date;
  return format(d, 'yyyy年MM月dd日 HH:mm', { locale: ja });
}

export function formatPrice(price: number): string {
  return `¥${price.toLocaleString('ja-JP')}`;
}

export function formatStatus(status: string): string {
  const statusMap: Record<string, string> = {
    'ongoing': '販売中',
    'upcoming': '販売予定',
    'ended': '終了',
    'accepting': '受付中',
    'not_started': '受付前',
    'pending': '保留中',
    'approved': '承認済み',
    'rejected': '却下',
  };
  return statusMap[status] || status;
}
