module Searchable
  results = def where(params)
    attr_names = params.keys
    where_line = attr_names
                 .map { |attr_name| "#{attr_name} = ?"}
                 .join(" AND ")
    results = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL
    parse_all(results)
  end
end
