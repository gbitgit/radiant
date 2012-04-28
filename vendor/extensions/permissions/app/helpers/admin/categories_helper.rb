module Admin::CategoriesHelper

  def tree_view(tree, opt = {})
    ul_tag_tree(tree, opt, 1)
  end

  private

  def ul_tag_tree(tree, opt, level)
    html =  "  " * level + (level == 1 ? "<ul id='#{opt[:id]}' class='#{opt[:class]}'>\n" : "<ul>\n")
    while tree.first
      t = tree.first
      if  t.level == level
        html << "  " * level + "  <li>" +
          link_to_function("<span class='#{opt[:span_class]}'>#{t.name}</span>",
                           "$('##{opt[:parent_id]}').flexLoadUrl('#{(t.path.to_json)}');
                            $('#name_area').show();
                            $('#name_area > h4').html('/#{t.path} path')")
        html << (tree[1] && tree[1].level == level ? "</li>\n" : "\n")
        tree.shift
      elsif t.level > level
        html << ul_tag_tree(tree, opt, level + 1)
      else
        break
      end
    end
    html + "  " * level + "</li></ul>\n"
  end

  end