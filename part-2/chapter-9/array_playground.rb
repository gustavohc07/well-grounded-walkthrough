# Flatten

array = [1,2,3,[5,6,[7,8]]]

array.flatten
# => [1, 2, 3, 5, 6, 7, 8]

array.flatten(1)
# => [1, 2, 3, 5, 6, [7, 8]]