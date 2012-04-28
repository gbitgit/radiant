
    class Category < ActiveRecord::Base
      set_table_name 'categories'

      TreeInfo = Struct.new(:level, :name, :path)

      def self.find_tree_info
        find_dir_tree([])
      end

      def self.find_by_path(path, opt = {})
        Category.find(:all, opt.merge({:conditions => build_path_conditions(path)}))
      end

      def self.count_by_path(path, opt = {})
        Category.count(:all, opt.merge({:conditions => build_path_conditions(path)}))
      end


      private

      def self.build_path_conditions(path)
        cond = {}
#        path.split(/\//).each_with_index {|e,ix| cond["dir#{ix + 1}"] = e}
        path.split(/\//).each_with_index {|e,ix| cond["parent_id"] = e}
        cond
      end

      def self.find_dir_tree(tree)
        logger.warn "\n###########################   find_dir_tree(#{tree})    ####################################"

        cond = {}
        tree.each_with_index {|e,ix| cond[:parent_id] = e[:id]}
        level = tree.size + 1
        dir_col = cond[:parent_id]
#        entries = Country.find(:all, :select => "distinct #{dir_col}",
#                            :conditions => cond).map {|e| e[dir_col]}
        entries = Category.find(:all, :select => "distinct name",
                            :conditions => cond).map {|e| e}
        list = []
        entries.select {|e| e != ""}.each {|e|
          down_tree = tree + [e]
          list.push(TreeInfo.new(level, e, down_tree.join('/')))
          list.concat(find_dir_tree(down_tree))  if (level <= 2)
        }
        list
      end


    end
