#include <iostream>
#include <chrono>
#include <fstream>
#include <vector>
#include <string>

using namespace std;

#define PROBLEM_NAME Problem14
#define SOLUTION_VAL 1
#define ITERS_TO_RUN 1

#define STRINGIZE2(s) #s
#define STRINGIZE(s) STRINGIZE2(s)
#define PROBLEM_FILE "Resources/" STRINGIZE(PROBLEM_NAME) ".txt"

#if SOLUTION_VAL == 1
	#define FUNCTION_NAME(a,b) PROBLEM_NAME
#else
	#define FUNCTION_NAME(a,b) a##_Sol_##b
#endif
#define FUNCTION_CALL FUNCTION_NAME(PROBLEM_NAME, SOLUTION_VAL)

extern "C" unsigned long long FUNCTION_CALL(int*);

void loadResource(vector<int> *v) {
	ifstream infile;
	infile.open(PROBLEM_FILE);
	if (infile.is_open()) {
		string str;
		while (getline(infile, str)) {
			v->push_back(stoi(str, NULL, 10));
		}
	}
}

int main() {
	vector<int> v;
	loadResource(&v);

	unsigned long long answer = 0;
	long long runtime = 0;

	for (int i = 0; i < ITERS_TO_RUN; i++) {
		auto start = chrono::high_resolution_clock::now();
		unsigned long long newAnswer = FUNCTION_CALL(v.data());
		auto stop = chrono::high_resolution_clock::now();
		runtime += chrono::duration_cast<chrono::microseconds>(stop - start).count();
		if (i == 0) {
			answer = newAnswer;
		} else if (answer != newAnswer) {
			cout << "Inconsisten answer recieved on iteration " << i + 1 << endl;
			cout << "Expected: " << answer << ", Actual: " << newAnswer;
			return 1;
		}
	}

	cout << "Answer: " << answer << endl;
	cout << "Avg Runtime: " << runtime / 1000.0 / ITERS_TO_RUN << " ms" << endl;
	cout << "Run over " << ITERS_TO_RUN << " iteration" << (ITERS_TO_RUN > 1 ? "s" : "") << endl;

	return 0;
}