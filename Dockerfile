FROM elixir:1.10

RUN mkdir -p /s_expr_calc

WORKDIR /s_expr_calc

COPY s_expr_calc/ .

RUN mix escript.build
