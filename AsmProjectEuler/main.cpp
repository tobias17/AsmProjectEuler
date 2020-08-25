#include <iostream>
#include <chrono>
#include <fstream>
#include <vector>
#include <string>

using namespace std;

#define PROBLEM_NAME Problem14
#define SOLUTION_VAL 1

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

	auto start = chrono::high_resolution_clock::now();
	unsigned long long ans = FUNCTION_CALL(v.data());
	auto stop = chrono::high_resolution_clock::now();
	auto duration = chrono::duration_cast<chrono::microseconds>(stop - start);

	cout << "Answer: " << ans << endl;
	cout << "Elapsed Time: " << duration.count() / 1000.0 << " ms" << endl;

	return 0;
}