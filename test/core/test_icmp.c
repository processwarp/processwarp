#include <stdio.h>

// 最適化阻止
int p_one = 1;
int p_two = 2;
int zero = 0;
int m_one = -1;
int m_two = -2;

int main() {
  printf("%d %d %d %d %d %d %d %d %d %d %d %d\n",
	 (p_one > p_two ? 1 : 0),
	 (p_two > p_one ? 1 : 0),
	 (p_one > p_one ? 1 : 0),
	 ((unsigned)p_one > (unsigned)p_two ? 1 : 0),
	 ((unsigned)p_two > (unsigned)p_one ? 1 : 0),
	 ((unsigned)p_one > (unsigned)p_one ? 1 : 0),
	 (m_one > m_two ? 1 : 0),
	 (m_two > m_one ? 1 : 0),
	 (m_one > m_one ? 1 : 0),
	 ((unsigned)m_one > (unsigned)m_two ? 1 : 0),
	 ((unsigned)m_two > (unsigned)m_one ? 1 : 0),
	 ((unsigned)m_one > (unsigned)m_one ? 1 : 0));
  printf("%d %d %d %d %d %d %d %d %d %d %d %d\n",
	 (p_one >= p_two ? 1 : 0),
	 (p_two >= p_one ? 1 : 0),
	 (p_one >= p_one ? 1 : 0),
	 ((unsigned)p_one >= (unsigned)p_two ? 1 : 0),
	 ((unsigned)p_two >= (unsigned)p_one ? 1 : 0),
	 ((unsigned)p_one >= (unsigned)p_one ? 1 : 0),
	 (m_one >= m_two ? 1 : 0),
	 (m_two >= m_one ? 1 : 0),
	 (m_one >= m_one ? 1 : 0),
	 ((unsigned)m_one >= (unsigned)m_two ? 1 : 0),
	 ((unsigned)m_two >= (unsigned)m_one ? 1 : 0),
	 ((unsigned)m_one >= (unsigned)m_one ? 1 : 0));
  printf("%d %d %d %d %d %d %d %d %d %d %d %d\n",
	 (p_one < p_two ? 1 : 0),
	 (p_two < p_one ? 1 : 0),
	 (p_one < p_one ? 1 : 0),
	 ((unsigned)p_one < (unsigned)p_two ? 1 : 0),
	 ((unsigned)p_two < (unsigned)p_one ? 1 : 0),
	 ((unsigned)p_one < (unsigned)p_one ? 1 : 0),
	 (m_one < m_two ? 1 : 0),
	 (m_two < m_one ? 1 : 0),
	 (m_one < m_one ? 1 : 0),
	 ((unsigned)m_one < (unsigned)m_two ? 1 : 0),
	 ((unsigned)m_two < (unsigned)m_one ? 1 : 0),
	 ((unsigned)m_one < (unsigned)m_one ? 1 : 0));
  printf("%d %d %d %d %d %d %d %d %d %d %d %d\n",
	 (p_one <= p_two ? 1 : 0),
	 (p_two <= p_one ? 1 : 0),
	 (p_one <= p_one ? 1 : 0),
	 ((unsigned)p_one <= (unsigned)p_two ? 1 : 0),
	 ((unsigned)p_two <= (unsigned)p_one ? 1 : 0),
	 ((unsigned)p_one <= (unsigned)p_one ? 1 : 0),
	 (m_one <= m_two ? 1 : 0),
	 (m_two <= m_one ? 1 : 0),
	 (m_one <= m_one ? 1 : 0),
	 ((unsigned)m_one <= (unsigned)m_two ? 1 : 0),
	 ((unsigned)m_two <= (unsigned)m_one ? 1 : 0),
	 ((unsigned)m_one <= (unsigned)m_one ? 1 : 0));
  printf("%d %d %d %d %d %d %d %d %d %d %d %d\n",
	 (p_one == p_two ? 1 : 0),
	 (p_two == p_one ? 1 : 0),
	 (p_one == p_one ? 1 : 0),
	 ((unsigned)p_one == (unsigned)p_two ? 1 : 0),
	 ((unsigned)p_two == (unsigned)p_one ? 1 : 0),
	 ((unsigned)p_one == (unsigned)p_one ? 1 : 0),
	 (m_one == m_two ? 1 : 0),
	 (m_two == m_one ? 1 : 0),
	 (m_one == m_one ? 1 : 0),
	 ((unsigned)m_one == (unsigned)m_two ? 1 : 0),
	 ((unsigned)m_two == (unsigned)m_one ? 1 : 0),
	 ((unsigned)m_one == (unsigned)m_one ? 1 : 0));
  printf("%d %d %d %d %d %d %d %d %d %d %d %d\n",
	 (p_one != p_two ? 1 : 0),
	 (p_two != p_one ? 1 : 0),
	 (p_one != p_one ? 1 : 0),
	 ((unsigned)p_one != (unsigned)p_two ? 1 : 0),
	 ((unsigned)p_two != (unsigned)p_one ? 1 : 0),
	 ((unsigned)p_one != (unsigned)p_one ? 1 : 0),
	 (m_one != m_two ? 1 : 0),
	 (m_two != m_one ? 1 : 0),
	 (m_one != m_one ? 1 : 0),
	 ((unsigned)m_one != (unsigned)m_two ? 1 : 0),
	 ((unsigned)m_two != (unsigned)m_one ? 1 : 0),
	 ((unsigned)m_one != (unsigned)m_one ? 1 : 0));
  return 0;
}
