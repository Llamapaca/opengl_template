[default]:
	clear
	g++  src/helloTriangle/main.cpp src/glad.c -I deps -lglfw3 -o build/main.out
	build/main.out
