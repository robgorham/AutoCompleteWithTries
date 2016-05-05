class Node
	def initialize(identifier = '')
		@ident = identifier
		@nodelist = {}
		@data =false
	end

	def AddNode(key, newLeaf)
		if @nodelist[key] != nil
			return @nodelist[key]
		end
		@nodelist[key] = Node.new(key)		
		
		@nodelist[key]
	end

	def SetData(data)
		@data = data
	end


	def GetNode(idx)
		@nodelist[idx]
	
	end
	def GetData()
		@data
	end

	def NodeList()
		@nodelist
	end

	def GetIndex()
		@ident
	end
end	
class Trie

	def initialize()
		@root = Node.new
	end

	def AddWord(word)
		AddWordHelper(word, word,@root)
	end

	def AddWordHelper(word, wordsleft,currNode )

		if wordsleft.size == 0
			currNode.SetData(true) #set the end of a word
			return
		end
		temp = currNode.AddNode(wordsleft[0], Node.new(wordsleft[0]))
		AddWordHelper(word,wordsleft[1...word.size], currNode.AddNode(temp.GetIndex, temp))
	end

	def GetAll()
		GetAllWords(@root)
		
	end
	def GetAllWords(node, currWord= "")
		words = []
		if (node.GetData() == true)
			words +=[ ( currWord + node.GetIndex().to_s) ]
		end
		if node.NodeList().size == 0
			return words
		end		
		currWord += node.GetIndex().to_s
		myNodeArray = node.NodeList()
		myNodeArray.each do |key, n|
		
			words += GetAllWords(n, currWord.to_s)
		end		
		words
	end

	def to_s()
		to_sHelper(@root, "")
	end
	def to_sHelper(node,currWord="")
		results = ""
		if (node.GetData() == true) #if this node is the endpoint of a word
			results = currWord + node.GetIndex().to_s + "\n"
		end
		if node.NodeList().size > 0
			currWord += node.GetIndex().to_s
			myNodeArray = node.NodeList()
			myNodeArray.each do |key, n|
				results = results + to_sHelper(n, currWord.to_s)
			end	
		end	
		results
	end

	def FindPossibles(guess) #find all possible words given a guess
		possibleNode = FindPossibleHelper(guess,@root)
		if possibleNode == nil
			return []
		end
		words = GetAllWords(possibleNode)
		(0...words.size).each do |i|
			words[i] = guess[0...guess.size-1] + words[i]
		end
		words
	end
	def FindPossibleHelper(charLeft, currNode)
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

myTrie = Trie.new
myTrie.AddWord("Dennis")
myTrie.AddWord("Robert")
 myTrie.AddWord("Rodney")
myTrie.AddWord("Hello")
myTrie.AddWord("Rodney DangerField")
myTrie.AddWord("Felecia")
myTrie.AddWord("Roxanne")
myTrie.AddWord("Robot")
puts myTrie.FindPossibles("Rob").to_s + "\n\n"
puts myTrie.GetAll()