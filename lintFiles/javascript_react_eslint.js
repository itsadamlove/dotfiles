module.exports = {
  parser: "babel-eslint", // Specifies the ESLint parser
  extends: [
    "airbnb-base",
    "plugin:react/recommended", // Uses the recommended rules from @eslint-plugin-react
    "prettier"
  ],
  plugins: ["prettier", "react"],
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
    semi: ["error", "always"]
    // Place to specify ESLint rules. Can be used to overwrite rules specified from the extended configs
    // e.g. "@typescript-eslint/explicit-function-return-type": "off",
  },
  settings: {
    react: {
      version: "detect" // Tells eslint-plugin-react to automatically detect the version of React to use
    }
  }
};
