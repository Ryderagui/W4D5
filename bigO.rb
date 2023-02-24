#

def my_min(list)

    list.each do |num|
        return num if list.all? {|num2| num <= num2}
    end
end

# O(n^2)
p my_min([0,3,5,4,-5,10])

def my_min_better(list)

    min = 10000

    list.each do |num|
        min = num if num <= min
    end
    min

end

#O(n)
p my_min_better([0,3,5,4,-5,10])

def large_cont_subsum(list)
    sub_arrys = []

    list.each_with_index do |ele,i|
        sub_arrys << [ele]
        list.each_with_index do |ele1,i1|
            if i1 > i
                sub_arrys << list[i..i1]
            end
        end
    end
    max = 0
    sub_arrys.each do |sum|
        max = sum.sum if sum.sum > max
    end
    max

end
list = [-2,3,-6,7,-6,7]
p large_cont_subsum(list)
# winner = -2
# current = -2
# either current = 1 or current = 3
def bet_large_cont_subsum(list)
    winner = -1000
    current = 0
    # -6, so current becomes -3, and winner is still 3
    # 7, so current is 4, but 4 is worse than 7 so current is 7 and winner is 7
    list.each_with_index do |num|
        current += num #1
        current = num if num > current # 3 > 1, forget adding, lets use 3 instead
        winner = current if current > winner #Now swap winner to 3.
    end
    winner
end

p bet_large_cont_subsum(list)


def first_anagram?(str1, str2)

    create_anagrams(str1).include?(str2)
end

def create_anagrams(str)

    chars = str.chars

    perms = chars.permutation(str.length)

    perms.map { |sub_perm| sub_perm.join("")}

    # take the first element of str and put it into an array. Take gizmo and grab a random char and add it to a str. if the str is not in the array then add it.

end

# p create_anagrams("gizmo")

# p first_anagram?("gizmo", "sally")    #=> false
# p first_anagram?("elvis", "lives")    #=> true


def second_anagram?(str1, str2)

    arr2 = str2.chars

    str1.each_char do |char|
        idx = arr2.index(char)
        next if idx.nil?
        arr2.delete_at(idx)
    end

    arr2.empty?

end

p second_anagram?("gizmo", "sally")    #=> false
p second_anagram?("elvis", "lives")    #=> true
