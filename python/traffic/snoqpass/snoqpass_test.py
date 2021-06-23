"""Unit tests for snoqpass.py"""
from unittest import TestCase, main
from snoqpass import extract_integer_value

class SnoqPassTestCase(TestCase):
    """Unit tests """

    def test_extract_integer_value(self):
        """Test ability to extract integer surrounded by text"""
        text = "<td><span class=\"green\">66</span></td>"
        expected = 66
        observed = extract_integer_value(text)
        self.assertEqual(expected, observed)


if __name__ == '__main__':
    main()
