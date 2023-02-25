#

require "byebug"

def my_min(list)

    list.each do |num|
        return num if list.all? {|num2| num <= num2}
    end
end

# O(n^2)
# p my_min([0,3,5,4,-5,10])

def my_min_better(list)

    min = 10000

    list.each do |num|
        min = num if num <= min
    end
    min

end

#O(n)
# p my_min_better([0,3,5,4,-5,10])

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
# p large_cont_subsum(list)
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

# p bet_large_cont_subsum(list)


def first_anagram?(str1, str2)

    create_anagrams(str1).include?(str2)
end

def create_anagrams(str)

    chars = str.chars

    perms = chars.permutation(str.length)

    perms.map { |sub_perm| sub_perm.join("")}

    # take the first element of str and put it into an array. Take gizmo and grab a random char and add it to a str. if the str is not in the array then add it.
    # 5, 120 5!. n!
end

# p create_anagrams("gizmo")

# p first_anagram?("gizmo", "sally")    #=> false
# p first_anagram?("elvis", "lives")    #=> true


def second_anagram?(str1, str2)

    arr2 = str2.chars

    str1.each_char do |char|
        idx = arr2.index(char)
        # this is likely a .each, for looping again
        next if idx.nil?
        arr2.delete_at(idx)
        # this is likely a .each
    end

    arr2.empty?

end

# p second_anagram?("gizmogizmogizmogizmo", "sallysallysallysally")    #=> false
# p second_anagram?("elviselviselviselvis", "liveslivesliveslives")    #=> true

# p first_anagram?("gizmogizmo", "sallysally")    #=> false
# p first_anagram?("elviselvis", "liveslives")    #=> true

def third_anagram?(str1,str2)
    chars1 = str1.chars
    # We have spent n time O(n)
    sort1 = chars1.sort
    # Add n log n time
    chars2 = str2.chars
    # add n time
    sort2 = chars2.sort
    # add n log n time
    sort1 == sort2
    # add 1

    # n + nlogn + n + nlogn => 2n + 2nlogn -> 2n (1 + logn)
    # n log n
end

# p third_anagram?("gizmogizmogizmogizmo", "sallysallysallysally")    #=> false
# p third_anagram?("elviselviselviselvis", "liveslivesliveslives")    #=> true
# Time time complexity is nlogn

def fourth_anagram?(str1,str2)
    hash = Hash.new(0)

    str1.each_char do |char|
        hash[char] += 1
    end

    str2.each_char do |char1|
        hash[char1] -= 1
    end

    hash.each do |k,v|
        return false if v != 0
    end
    true
end

# p fourth_anagram?("gizmogizmogizmogizmo", "sallysallysallysally")    #=> false
# p fourth_anagram?("elviselviselviselvis", "liveslivesliveslives")    #=> true


def bad_two_sum?(arr, target_sum)

    arr.each_with_index do |num1, i1|
        arr.each_with_index do |num2, i2|
            if i2 > i1 && num1 + num2 == target_sum
                return true
            end
        end
    end

    false

end

# n^2

arr = [0, 1, 5, 7]
# p bad_two_sum?(arr, 6) # => should be true
# p bad_two_sum?(arr, 10) # => should be false


def okay_two_sum?(arr, target_sum)

    sorted = arr.sort

    sorted.each do |num|
        pair = target_sum - num
        next if pair == num
        return true if sorted.bsearch { |x| x == pair }
    end

    false

end

# n log n

arr = [0, 1, 5, 7]
# p okay_two_sum?(arr, 6) # => should be true
# p okay_two_sum?(arr, 10) # => should be false


def hash_two_sum?(arr, target_sum)

    hash = Hash.new(0)

    arr.each do |num|
        pair = target_sum - num
        return true if hash[pair] > 0
        hash[num] += 1
    end

    false
end

# O(n)

# p hash_two_sum?(arr, 6) # => should be true
# p hash_two_sum?(arr, 10) # => should be false

# ---------------------------------------------------------------------------------------------------------------------


# step 1 define window max range. It will take in an array and sixe
# step 2 find all the sub arrays of length size
# the best sub array is the one of max - min of its values


def naive_windowed_max_range(array, window_size)

    current_max_range = nil

# debugger

    array.each_with_index do |window, i|
        next if (i + window_size - 1) >= array.length

        sub_window = array[i...(i + window_size)]
        max = sub_window.max
        min = sub_window.min

        if current_max_range.nil?
            current_max_range = (max - min)
        elsif (max - min) > current_max_range
            current_max_range = (max - min)
        end

    end

    current_max_range

end

# n^2

# p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8


# ---------------------------------------------------------------------------------------------------------------------


class MyQueue


    def initialize
        @store = []
    end

    def enqueue(ele)
        @store << ele
    end

    def dequeue
        @store.shift
        # [1,2,3] => [2,3] => self[1..-1]
    end

    def peek
        @store.first
    end

    def size
        @store.length
    end

    def empty?
        @store.empty?
    end

end


class MyStack

    attr_reader :min, :max

    def initialize
        @store = []
        @min = 0
        @max = 0
    end

    def push(ele)
        @store.push(ele) # <<

        if ele > @max
            @max = ele
        end

        if @min.nil?
            @min = ele
        elsif ele < @min
            @min = ele
        end

    end

    def pop
        @store.pop
    end

    def peak
        @store[-1]
    end

    def size
        @store.size
    end

    def empty?
        @store.empty?
    end

end

class StackQueue < MyStack

    def initialize
        super
        @front = MyStack.new
        @back = MyStack.new
    end
    #Our end goal is a Queue
    # stack 1 [5,6,7]
    # stack 2 [4,3,2,1]

    def enqueue(ele)
        @back.push(ele)
    end

    def dequeue
        if @front.empty?
            self.slinky
        end
        @front.pop
    end

    def size
        @front.size + @back.size
    end

    def empty?
        @front.empty? && @back.empty?
    end

    def min
        @front.min < @back.min ? @front.min : @back.min
    end

    def max
        @front.max > @back.max ? @front.max : @back.max
    end

    private

    def slinky
        until @back.empty?
            @front.push(@back.pop)
        end
        return
    end

end


def windowed_max_range(array, window_size)

    current_max_range = nil
    queue = StackQueue.new

# debugger

    array.each_with_index do |num, i|
        queue.enqueue(num)
        if queue.size > window_size
            queue.dequeue
        end

        if current_max_range.nil?
            current_max_range = (max - min)
        elsif (max - min) > current_max_range
            current_max_range = (max - min)
        end

    end

    current_max_range

end

p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
