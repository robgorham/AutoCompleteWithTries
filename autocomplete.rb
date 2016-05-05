class Trie

	class Node
		def initialize(identifier = '')
			@ident = identifier
			@nodelist = {}
			@data =false
		end

		def AddNode(key, newLeaf)
			if @nodelist[key] == nil
				@nodelist[key] = newLeaf				
			end
			puts "added #{newLeaf.GetIndex()}"
			@nodelist[key]
		end

		def SetData(data)
			@data = data
		end


		def GetNode(key)
			@nodelist[key]
		
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

	def initialize()
		@root = Node.new
		@levelsdeep = 0
	end

	def AddWord(word)
		AddWordHelper(word, word,@root)
		puts "added#{word}" + @root.NodeList.size.to_s
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
		if node != nil
			currWord = currWord + node.GetIndex().to_s
			return
		end
		if node == nil
			return
		end
		if node.GetData()
			words << currWord
		end
		if node.NodeList() != {}
			node.NodeList.each do |nextNode|
				words << GetAllWords(nextNode,currWord )
			end
		end
		words
	end

	def to_s(node=@root ,currWord="")
		res = ""
		puts "to_s"
		if node != nil
			currWord = currWord + node.GetIndex().to_s
			return
		end
		if node == nil
			return
		end
		if node.GetData()
			res = currWord
		end
		if node.NodeList() != {}
			node.NodeList.each do |nextNode|
				puts " search"
				res += res to_s(nextNode,currWord )+ " "
			end
		end
		res
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
myTrie.AddWord("Rodney")
myTrie.AddWord("Hello")
myTrie.AddWord("Rodney DangerField")
#puts myTrie.FindPossible("R")
puts myTrie.to_s()