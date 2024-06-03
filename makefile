[default]:
	clear
	mkdir -p build 
	cmake -S . -B build 
	cmake --build ./build
	./build/lopengl

clear:
	rm -rf ./build/*
