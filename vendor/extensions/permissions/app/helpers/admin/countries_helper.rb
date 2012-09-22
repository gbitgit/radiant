module Admin::CountriesHelper


def select_tag_for_filter33(model, nvpairs, params)
  options = { :query => params[:query] }
  _url = url_for(eval("admin_#{model}_url(options)"))
  _html = %{<label for="show">Show country:</label><br />}
  _html << %{<select name="show" id="show"}
  _html << %{onchange="window.location='#{_url}' + '?show=' + this.value ">}
  nvpairs.each do |pair|
    _html << %{<option value="#{pair[:scope]}"}
    if params[:show] == pair[:scope] || ((params[:show].nil? ||
params[:show].empty?) && pair[:scope] == "all")
      _html << %{ selected="selected"}
    end
    _html << %{>#{pair[:label]}}
    _html << %{</option>}
  end
  _html << %{</select>}
end



end