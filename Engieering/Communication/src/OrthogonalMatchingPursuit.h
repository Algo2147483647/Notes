#include "C:/LiGu/LiGu_Codes/LiGu_Math/src/Math/Matrix/Matrix.h"

using namespace Matrix;

/*
 * Õý½»Æ¥Åä¸ú×Ù
 */
Mat<>& OrthogonalMatchingPursuit(Mat<>& A, Mat<>& b, Mat<>& x, int s)
{
	static Mat<> r, lamb, A_, tmp;
	int index;
	r = b;
	lamb.zero(s);
	x.zero(A.cols);

	for (int i = 0; i < s; i++) {
		mul(tmp, transpose(tmp, A), r);

		for (int j = 0; j < tmp.size(); j++)
			tmp(j) *= tmp(j) < 0 ? -1 : 1;
		for (int j = 0; j < i; j++)
			tmp(lamb(j)) = 0;

		max(tmp, index);
		lamb[i] = index;

		A_.alloc(A.rows, i + 1);
		for (int j = 0; j <= i; j++) {
			for (int k = 0; k < A.rows; k++) {
				A_(k, j) = A(k, lamb(j));
			}
		}

		mul(tmp, pinv(tmp, A_), b);

		for (int j = 0; j <= i; j++) {
			x(lamb(j)) = tmp(j);
		}

		sub(r, b, mul(tmp, A, x));
	}

	return x;
}