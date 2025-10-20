export type TodoItem = { title: string; detail?: string; createdAt: string; done?: boolean }

let todos: TodoItem[] = []

export function getTodos(): TodoItem[] {
  return todos
}

export function addTodo(item: TodoItem): void {
  // 新增放在顶部，保持从上往下（新到旧）显示
  todos = [item, ...todos]
}

export function toggleDone(index: number): void {
  todos = todos.map((t, i) => (i === index ? { ...t, done: !t.done } : t))
}

export function clearTodos(): void {
  todos = []
}