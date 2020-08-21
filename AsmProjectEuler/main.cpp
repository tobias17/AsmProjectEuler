#include <iostream>
#include <chrono>

using namespace std;

#define PROBLEM_NAME Problem7

extern "C" unsigned long long PROBLEM_NAME();

int main() {
	auto start = chrono::high_resolution_clock::now();
	int ans = PROBLEM_NAME();
	auto stop = chrono::high_resolution_clock::now();
	auto duration = chrono::duration_cast<chrono::microseconds>(stop - start);

	cout << "Answer: " << ans << endl;
	cout << "Elapsed Time: " << duration.count() / 1000.0 << " ms" << endl;

	return 0;
}