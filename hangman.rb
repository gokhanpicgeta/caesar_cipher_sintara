require 'sinatra'
require 'sinatra/reloader'

enable :sessions

wordList = ["awake","form","scintilating","short","snatch","pets","befitting","exciting","resolute","live","martial"]
wordLen = 0
get '/' do 

	session[:lives] = 6
	session[:guessList] = ""
	session[:wrongList] = ""
	session[:word] = wordList.sample(1)
	@val = session[:word]
	puts session[:word]
	wordLen = session[:word][0].length
	session[:starWord] = ""
	wordLen.times do 

		session[:starWord].concat("*")

	end 
	redirect to ("/newGame")

end 


get '/newGame' do 

	letter = params['guess']
	if letter != nil
		flag = 0
		session[:guessList].concat(letter)

		wordLen.times do |i|
			if session[:word][0][i] == letter 

				session[:starWord][i] = letter
				flag = 1

			end 
		end 

		if flag == 0 
			session[:wrongList].concat(letter)
			session[:lives]-=1
		end 

	end 


	if session[:starWord] == session[:word][0]

		redirect to ("/win")

	end 

	if session[:lives] < 0 

		redirect to ("/lose")
	end 


	erb :index, :locals => {:word => session[:word],:starWord => session[:starWord], :lives => session[:lives], :wrongGuesses => session[:wrongList]}

end 

get '/win' do 

	"YOU WON WOOOOO"

end 

get '/lose' do


	"BOOO YOU LOST"

end  
