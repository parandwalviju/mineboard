  #!/usr/bin/env ruby
  # Minesweeper class 
  class Minesweeper
    DIFF_EASY = 50 #percentage to calculate mines based on square 
    DIFF_MEDIUM = 30
    DIFF_HARD = 20	
    MINE_MARKER = "*" 
    EMPTY_MARKER = "."
    EXPLODED_MARKER = "X"
    attr :status
    def initialize(square, diffLevel = "easy")
    @width = square
    @height = square
    numMines = getMinesByDiffLevel(square, diffLevel) #function to get mines 
      @mines = []
      numMines.times do 
        mine = nil 
        while not mine	  	
          mine = [rand(@width), rand(@height)]
          if @mines.include?(mine)
            mine = nil
          else
            @mines << mine
          end
        end
      end

    @status = "Still Playing"

    end  
    #function to draw the board
    def drawBoard()  
    #1. prepare the default board
      @height.times do |y|
        @width.times do |x|
          print EMPTY_MARKER
        end
        puts
      end	
      @squares = []
      @width.times do |x|
        column = []
        @height.times do |y|
          column << EMPTY_MARKER
        end
        @squares << column
      end	
    # 2. fill the mine marker
      @mines.each do |mine|
        x,y = mine
        @squares[x][y] = MINE_MARKER
      end		
    #puts @squares;

    end
    # attempt - function to attempt the mine game
    def attempt(x,y) 
    if x >@height or y> @height
      abort("Invalid coordinates!")
    end

     if not isMine(x,y)		
      #puts "LOOSE"
      @status  = "LOOSE\nYou Loose!"	
    else
      #puts "BOOOOOM"
      @status = "BOOOOOM\nYou Won!"	
     end  
    end
    # status - function to get the status the mine game
    def status()
     puts @status
    end
    # isMine - function to get the isMine true or false
     def isMine(x,y)
      @squares[x][y] == MINE_MARKER
    end   
    # getMinesByDiffLevel - function to get diff level
    def getMinesByDiffLevel(square, diffLevel)
    numMines = 1
    diffLevel = diffLevel.downcase	
    if diffLevel.to_s.eql? "easy"
      numMines = (square * (1 - DIFF_EASY / 100.0)).to_i		
    end
    if diffLevel.to_s.eql? "medium"
      numMines = (square * (1 - DIFF_MEDIUM / 100.0)).to_i		
    end
    if diffLevel.to_s.eql? "hard"
      numMines = (square * (1 - DIFF_HARD / 100.0)).to_i		
    end
    puts numMines	
    numMines
    end  
  end
