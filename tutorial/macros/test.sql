{% macro get_payment_methods() %}
    ['credit_card', 'coupon', 'bank_transfer', 'gift_card']
{% endmacro %}

{% macro calculate_method_amounts(payment_methods, amount_column='amount', payment_method_column='payment_method') %}
    {% for payment_method in payment_methods -%}
        sum(case when {{ payment_method_column }} = '{{ payment_method }}' then {{ amount_column }} else 0 end) as {{ payment_method }}_amount,
    {% endfor -%}
{% endmacro %}
