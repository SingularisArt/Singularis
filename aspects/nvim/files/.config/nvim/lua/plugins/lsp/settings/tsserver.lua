return {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
      format = {
        semicolons = "insert",
        convertTabsToSpaces = false,
        insertSpaceAfterCommaDelimiter = true,
        insertSpaceAfterConstructor = true,
        insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
        insertSpaceAfterKeywordsInControlFlowStatements = true,
        insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true,
        insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = true,
        insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
        insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = true,
        insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = true,
        insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = true,
        insertSpaceAfterSemicolonInForStatements = true,
        insertSpaceAfterTypeAssertion = true,
        insertSpaceBeforeAndAfterBinaryOperators = true,
        insertSpaceBeforeFunctionParenthesis = true,
        insertSpaceBeforeTypeAnnotation = true,
        placeOpenBraceOnNewLineForControlBlocks = true,
        placeOpenBraceOnNewLineForFunctions = true,
        trimTrailingWhitespace = true,
      },
    },
  },
}
