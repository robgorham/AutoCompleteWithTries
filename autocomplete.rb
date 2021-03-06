
#Robert Gorham 2016
#Declare a Trie by 
# myTrie = Trie.new
#Add Words myTrie.AddWord("Foobar")
#Find Possibles by myTrie.FindPossibles(string)
#Also  myTrie.to_s  gives all words as a string
#You can find any piece of data in this 
class Trie
	class Node
		@ident
		@nodelist
		@data		

		attr_accessor :data
		attr_reader :nodelist
		attr_accessor :ident
		
		def GetNode(idx)
			@nodelist[idx]		
		end

		def initialize(identifier = '')
			@ident = identifier
			@nodelist = {}
			@data = false
		end

		def AddNode(key, newLeaf)
			if @nodelist[key] != nil
				return @nodelist[key]
			end
			@nodelist[key] = Node.new(key)		
			
			@nodelist[key]
		end
	end

		
	def initialize
		@root = Node.new
	end

	
	def AddFile(filename)
		dict = open(filename)
		words = dict.read
		list = words.split("\n")
		list.each do |word|
			AddWord(word)
		end		
	end

	#adds word to Structure
	def AddWord(word)
		AddWordHelper(word, word, @root)
	end
	
	def AddWordHelper(word, wordsleft, currNode )

		if wordsleft.size == 0
			currNode.data = true #set the end of a word
			return
		end
		temp = currNode.AddNode(wordsleft[0], Node.new(wordsleft[0]))
		AddWordHelper(word, wordsleft[1...word.size], currNode.AddNode(temp.ident, temp))
	end

	#returns ARray of all Strin gs
	def GetAll
		GetAllWords(@root)		
	end

	def GetAllWords(node, currWord= "")
		words = []
		if (node.data == true)
			words +=[(currWord + node.ident.to_s)]
		end
		if node.nodelist.size == 0
			return words
		end		
		currWord += node.ident.to_s
		myNodeArray = node.nodelist
		myNodeArray.each do |key, n|
		
			words += GetAllWords(n, currWord)
		end		
		words
	end

	##To output all of the words! in strings
	def to_s
		to_sHelper(@root)
	end
	
	def to_sHelper(node,currWord="")
		results = ""
		currWord += node.ident.to_s
		if (node.data == true) #if this node is the endpoint of a word
			results = currWord + "\n"
		end
		if node.nodelist.size > 0			
			myNodeArray = node.nodelist
			myNodeArray.each do |key, n|
				results = results + to_sHelper(n, currWord)
			end	
		end	
		
		results
	end

	def FindPossibles(guess) #find all possible words given a guess
		possibleNode = FindPossibleHelper(guess,@root) #find the node that corresponds to the guess
		if possibleNode == nil
			return []
		end
		words = GetAllWords(possibleNode)#find all children
		(0...words.size).each do |i|
			words[i] = guess[0...guess.size-1] + words[i]
		end
		
		words
	end
	
	def FindPossibleHelper(charLeft, currNode)#travels out to the branch needed... RO in the ROBERT tree. then returns that Node
		if currNode == nil
			return nil
		end
		if charLeft.size == 0
			return currNode
		end
		
		FindPossibleHelper(charLeft[1...charLeft.size],currNode.GetNode(charLeft[0]))
	end
	
	def FindNode(key, currNode)
		FindPossibleHelper(key, @root)
	end
	
end


filename = "wordsEn.txt"

myTrie = Trie.new
myTrie.AddFile(filename)
guess = ""
puts myTrie.FindPossibles("dn").to_s #findall the possibles starting with dn
while guess != "qqq"
	puts "Enter some letters or qqq to quit"
	guess = gets.chomp
	autoc = myTrie.FindPossibles(guess)
	if autoc.size != 0
		puts autoc.to_s
	else 
		puts "No Such Possibilities"
	end
end 
		
		