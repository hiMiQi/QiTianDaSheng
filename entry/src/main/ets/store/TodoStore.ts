export type TodoItem = { title: string; detail?: string; createdAt: string; done?: boolean }

let todos: TodoItem[] = []

function formatDate(d: Date): string {
  const pad = (n: number) => (n < 10 ? '0' + n : n.toString())
  return `${pad(d.getMonth() + 1)}月${pad(d.getDate())}日 ${pad(d.getHours())}:${pad(d.getMinutes())}`
}

function ensureDefaults(): void {
  if (todos.length === 0) {
    const now = new Date()
    const t = (ms: number) => new Date(now.getTime() - ms)
    todos = [
      { title: '买菜清单', detail: '西红柿 / 鸡蛋 / 牛奶', createdAt: formatDate(t(30 * 60 * 1000)), done: false },
      { title: '跑步 5 公里', detail: '晚饭后去河边跑步', createdAt: formatDate(t(2 * 60 * 60 * 1000)), done: false },
      { title: '读书 30 分钟', detail: '继续《小王子》第三章', createdAt: formatDate(t(3 * 60 * 60 * 1000)), done: false },
      { title: '学习 TypeScript', detail: '泛型与类型推断', createdAt: formatDate(t(6 * 60 * 60 * 1000)), done: false },
      { title: '整理房间', detail: '收纳、擦桌子、倒垃圾', createdAt: formatDate(t(12 * 60 * 60 * 1000)), done: false },
      { title: '明日计划', detail: '早起、早餐、通勤时间安排', createdAt: formatDate(t(24 * 60 * 60 * 1000)), done: false },
    ]
  }
}

export function getTodos(): TodoItem[] {
  ensureDefaults()
  return todos
}

export function addTodo(item: TodoItem): void {
  todos = [item, ...todos]
}

export function toggleDone(index: number): void {
  todos = todos.map((t, i) => (i === index ? { ...t, done: !t.done } : t))
}

export function clearTodos(): void {
  todos = []
}