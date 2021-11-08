<?php

$finder = PhpCsFixer\Finder::create()
    ->in(__DIR__ . "/app/");

return PhpCsFixer\Config::create()
    ->setRules([
        '@PSR2' => true,
        '@Symfony' => true,
        'align_multiline_comment' => true,
        'array_syntax' => [
            'syntax' => 'short'
        ],
        'array_indentation' => true,
        'blank_line_after_namespace' => true,
        'binary_operator_spaces' => [
            'default' => 'single_space'
        ],
        'blank_line_after_namespace' => true,
        'blank_line_after_opening_tag' => false,
        'blank_line_before_return' => true,
        'braces' => [
            'allow_single_line_closure' => true,
            'position_after_anonymous_constructs' => 'same',
            'position_after_control_structures' => 'same',
            'position_after_functions_and_oop_constructs' => 'next'
        ],
        'cast_spaces' => [
            'space' => 'single'
        ],
        'class_attributes_separation' => [
            'elements' => [
                'const',
                'method',
                'property'
            ]
        ],
        'class_keyword_remove' => false,
        'combine_consecutive_issets' => true,
        'combine_consecutive_unsets' =>  true,
        'concat_space' => [
            'spacing' => 'one'
        ],
        'constant_case' => [
            'case' => 'lower'
        ],
        'date_time_immutable' => true,
        'declare_equal_normalize' => [
            'space' => 'single'
        ],
        'dir_constant' => false,
        'elseif' => true,
        'encoding' => true,
        'ereg_to_preg' => true,
        'explicit_indirect_variable' => true,
        'final_static_access' => true,
        'full_opening_tag' => true,
        'function_declaration' => true,
        'function_typehint_space' => true,
        'include' => true,
        'implode_call' => true,
        'increment_style' => [
            'style' => 'pre'
        ],
        'indentation_type' => true,
        'line_ending' => true,
        'linebreak_after_opening_tag' => true,
        'list_syntax' => [
            'syntax' => 'long'
        ],
        'logical_operators' => true,
        'lowercase_cast' => true,
        'lowercase_keywords' => true,
        'lowercase_static_reference' => true,
        'magic_constant_casing' => true,
        'magic_method_casing' => true,
        'mb_str_functions' => true,
        'method_chaining_indentation' => true,
        'modernize_types_casting' => true,
        'multiline_comment_opening_closing' => true,
        'multiline_whitespace_before_semicolons' => [
            'strategy' => 'no_multi_line'
        ],
        'native_function_casing' => true,
        // native_function_invocation - discussion needed
        'native_function_type_declaration_casing' => true,
        'new_with_braces' => true,
        'no_alternative_syntax' => true,
        'no_blank_lines_after_class_opening' => true,
        'no_blank_lines_after_phpdoc' => true,
        'single_blank_line_before_namespace' => false,
        'no_closing_tag' => true,
        'no_empty_comment' => true,
        'no_empty_phpdoc' => true,
        'no_empty_statement' => true,
        'no_leading_import_slash' => true,
        'no_leading_namespace_whitespace' => true,
        'no_mixed_echo_print' => [
            'use' => 'echo'
        ],
        'no_multiline_whitespace_around_double_arrow' => true,
        'no_multiline_whitespace_before_semicolons' => true,
        'no_null_property_initialization' => true,
        'no_php4_constructor' => true,
        'no_short_bool_cast' => true,
        'no_short_echo_tag' => true,
        'no_singleline_whitespace_before_semicolons' => true,
        'no_spaces_after_function_name' => true,
        'no_spaces_around_offset' => [
            'positions' => [
                'inside',
                'outside'
            ]
        ],
        'no_spaces_inside_parenthesis' => true,
        'no_superfluous_elseif' => true,
        'no_trailing_comma_in_list_call' => false,
        'no_trailing_comma_in_singleline_array' => false,
        'no_trailing_whitespace' => true,
        'no_trailing_whitespace_in_comment' => true,
        'no_unneeded_control_parentheses' => [
            'statements' => [
                'break',
                'clone',
                'continue',
                'echo_print',
                'return',
                'switch_case',
                'yield'
            ]
        ],
        'no_unneeded_curly_braces' => true,
        'no_unreachable_default_argument_value' => true,
        'no_unset_cast' => true,
        'no_unset_on_property' => false,
        'no_unused_imports' => true,
        'no_useless_else' => true,
        'no_useless_return' => true,
        'no_whitespace_in_blank_line' => true,
        'normalize_index_brace' => true,
        'object_operator_without_whitespace' => true,
        'phpdoc_add_missing_param_annotation' => false,
        'phpdoc_align' => [
            'align' => 'left',
            'tags' => [
                'param',
                'return',
                'throws',
                'type',
                'var'
            ]
        ],
        'phpdoc_annotation_without_dot' => true,
        'phpdoc_indent' => true,
        'phpdoc_no_access' => true,
        'phpdoc_no_alias_tag' => true,
        'phpdoc_no_empty_return' => false,
        'phpdoc_no_package' => true,
        'phpdoc_no_useless_inheritdoc' => true,
        'phpdoc_order' => true,
        'phpdoc_return_self_reference' => [
            'replacements' => [
                'this' => '$this',
                '@this' => '$this',
                '$self' => 'self',
                '@self' => 'self',
                '$static' => 'static',
                '@static' => 'static'
            ]
        ],
        'phpdoc_scalar' => [
            'types' => [
                'boolean',
                'double',
                'integer',
                'real',
                'str'
            ]
        ],
        'phpdoc_single_line_var_spacing' => true,
        'phpdoc_to_comment' => true,
        'no_superfluous_phpdoc_tags' => false,
        'no_blank_lines_before_namespace' => true,
        'yoda_style' => false,
        'method_argument_space' => [
            'on_multiline' => 'ignore',
            'keep_multiple_spaces_after_comma' => false,
        ],
        'declare_strict_types' => true,
    ])
    ->setRiskyAllowed(true)
    ->setFinder($finder)
;
