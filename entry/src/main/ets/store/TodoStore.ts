export type TodoItem = { title: string; detail?: string; createdAt: string; done?: boolean }

let todos: TodoItem[] = []

export function getTodos(): TodoItem[] {
  return todos
}

export function addTodo(item: TodoItem): void {
  // 新增追加到底部，保持自上而下（旧在上，新在下），首项位置不变
  todos = [...todos, item]
}

export function toggleDone(index: number): void {
  todos = todos.map((t, i) => (i === index ? { ...t, done: !t.done } : t))
}

export function clearTodos(): void {
  todos = []
}