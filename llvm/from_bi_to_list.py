n = int(input())
c = 0
V = [[] for i in range(n)]
for i in range(n):
    a = input()
    for j in range(len(a)):
        if a[j] == '%' and int(a[j+1]) > n:
            V[i].append(int(a[j+1]) - n + 1)
            c += 1
V = [[]] + V
print(len(V), c)
for i in range(len(V)):
    for j in range(len(V[i])):
        print(i, V[i][j])

