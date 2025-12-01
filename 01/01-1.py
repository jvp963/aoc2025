movements = [ ]
with open('input.txt', 'r') as inputfile:
    for line in inputfile:
        movements.append(line.strip())

position = 50
zero_counter = 0

for movement in movements:
    direction = movement[0:1]
    steps = int(movement[1:])

    # adjust the dial
    if (direction == 'L'):
        position = position - steps
    elif (direction == 'R'):
        position = position + steps

    # account for overruns
    while position >= 100:
        position = position - 100
    while position < 0:
        position = position + 100

    # if we're on zero, increment the counter
    if position == 0:
        zero_counter = zero_counter + 1

print(f'We landed on zero {zero_counter} times!')
