import terraform_validate
import unittest
import os
import sys

""" Not sure terraform_validate have support to check
for modules but at least we can check our defaults
"""


class TestWebAppResources(unittest.TestCase):

    def setUp(self):
        """Tell the module where to find your terraform
        configuration folder
        """
        self.path = os.path.join(os.path.dirname(os.path.realpath(__file__)),
                                 "../../")
        self.v = terraform_validate.Validator(self.path)

    def test_variables_defaults(self):
        """Assert that default exists.
        """
        self.v.variable('location').default_value_equals('UK South')
        self.v.variable('address_space').default_value_equals(["10.0.0.0/16"])
        self.v.variable('address_prefixes').default_value_equals(["10.0.0.0/24"])
        self.v.variable('subnetinstance_count').default_value_equals(1)


if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(TestWebAppResources)
    result = unittest.TextTestRunner(verbosity=1).run(suite)
    sys.exit(not result.wasSuccessful())
