module.exports = {
  parser: "@typescript-eslint/parser", // Specifies the ESLint parser
  extends: [
    "airbnb-base",
    "plugin:@typescript-eslint/recommended", // Uses the recommended rules from @typescript-eslint/eslint-plugin
    "prettier",
    "prettier/@typescript-eslint"
  ],
  plugins: ["prettier", "@typescript-eslint"],
  parserOptions: {
    ecmaVersion: 2018, // Allows for the parsing of modern ECMAScript features
    sourceType: "module", // Allows for the use of imports
    ecmaFeatures: {
      jsx: true // Allows for the parsing of JSX
    }
  },
  rules: {
    indent: [
      "error",
      2,
      {
        SwitchCase: 1
      }
    ],
    "linebreak-style": ["error", "unix"],
    quotes: ["error", "single"],
    semi: ["error", "always"],
    "@typescript-eslint/indent": 0
    // Place to specify ESLint rules. Can be used to overwrite rules specified from the extended configs
    // e.g. "@typescript-eslint/explicit-function-return-type": "off",
  },
  settings: {}
};
