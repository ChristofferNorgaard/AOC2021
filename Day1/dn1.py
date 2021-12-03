a = []
while True:
    inp = input()
    if inp == "":
        break
    a.append(int(inp))
num = 0
rlng = 0
def rnlg(i, s):
    return sum(a[(i-s):i])
for i in range(3, len(a)):
    num += (rnlg(i-1, 3) < rnlg(i, 3))
print(num)