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
		puts "added to node"
		
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
		@levelsdeep = 0
	end

	def AddWord(word)
		AddWordHelper(word, word,@root)
		puts "added#{word} in AddWord " + @root.NodeList.size.to_s
	end

	def AddWordHelper(word, wordsleft,currNode )

		if wordsleft == nil
			currNode.SetData(true) #set the end of a word
			puts "end of sentence"
			return
		end

		temp = currNode.AddNode(wordsleft[0], Node.new(wordsleft[0]))
		AddWordHelper(word,wordsleft[1...word.size], currNode.AddNode(temp.GetIndex, temp))
	end

	def FindPossible(word)
		words = GetAllWords(FindPossibleHelper(word))
		@levelsdeep = 0
		words
	end

	def GetAllWords(node = @root, currWord= "")
		words = []
		puts "getwords"
		if node.GetData() || (node.NodeList().size == 0)
			currWord = currWord + node.GetIndex().to_s
			words << currWord
		end
		if node.NodeList() != {}
			node.NodeList.each do |nextNode|
				words << GetAllWords(nextNode,currWord )
			end
		end
		words
	end

	def to_s()
		to_sHelper(@root, "")
	end
	def to_sHelper(node,currWord="")
		#puts currWord		
		#puts node.GetIndex()						
		if node.GetData()
			currWord = currWord + node.GetIndex().to_s
		end
		if node.NodeList().size > 0
			myNodeArray = node.NodeList()
			myNodeArray.each do |key, n|
				#puts " search #{key}"
				currWord = currWord + to_sHelper(n, currWord.to_s+key.to_s)+ " "
			end
		end
		currWord
	end

	def FindPossibleHelper(charLeft, currNode = @root, results = [])
		puts "possiblehelper"
		@levelsdeep  += 1
		if currNode == nil
			return nil
		end
		if charLeft == nil
			return currNode
		end

		FindPossibleHelper(charLeft[1...charLeft.size],currNode.GetNode(charLeft[0]))
	end
	def PrintRoot()
		puts @root.NodeList.size
	end



end

myTrie = Trie.new
myTrie.AddWord("Robert")
=begin myTrie.AddWord("Rodney")
myTrie.AddWord("Hello")
myTrie.AddWord("Rodney DangerField")
myTrie.AddWord("Felecia")
=end #puts myTrie.FindPossible("R")
myTrie.PrintRoot()
puts myTrie.to_s()