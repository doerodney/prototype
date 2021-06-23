# from traffic.snoqpass.snoqpass import extract_integer_value
from unittest import TestCase, main
from snoqpass import extract_integer_value

class SnoqPassTestCase(TestCase):
    """Unit tests """

    def test_extract_integer_value(self):
        text = "<td><span class=\"green\">66</span></td>"
        expected = 66
        observed = extract_integer_value(text)
        self.assertEqual(expected, observed)


if __name__ == '__main__':
    main()