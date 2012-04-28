
    module Admin::DataPermissionsHelper


      def update_crud

      end

      def trdgroup_column(record, column)
       #      Group.find_by_id(:first,record.group_id)[:code].to_s
#            case record.sh_acc_type
#            when 'G' then image_tag("/images/common/google_icon.png", :alt => "Google")
#            when 'Y' then image_tag("/images/common/yahoo_icon.png", :alt => "Yahoo")
#            end
      end

def bit_crud_form_column(record, column)
logger.warn "#{Time.now.strftime("%H:%M:%S:%3N")} bit_crud_column record.bit_crud=#{record.bit_crud} #{record.class} record=#{record.inspect}"
html = ''
arr = ['CREATE', 'READ', 'UPDATE', 'DELETE']
record[:bit_crud].split(//).each_with_index do |val,ind|
html << check_box_tag("record[checklist][]", val=='1', :id => "check_#{val}")
html << "<label for='check_#{val}'>"
html << "#{arr[ind]}"
html << "</label>"
end
html
end

def bit_crud_column(record)
#logger.warn "#{Time.now.strftime("%H:%M:%S:%3N")} bit_crud_column record.bit_crud=#{record.bit_crud} record=#{record.inspect}"

if !record.bit_crud.nil?
  #record.bit_crud.split(//).collect{|b| h(b)}.join(' :: ')
html = ''
arr = ['CREATE', 'READ', 'UPDATE', 'DELETE']
record[:bit_crud].split(//).each_with_index do |val,ind|
html << check_box_tag("record[checklist][]", val=='1', :id => "check_#{val}")
html << "<label for='check_#{val}'>"
html << "#{arr[ind]}"
html << "</label>"
end
html
else
  active_scaffold_config.list.empty_field_text
end

#html = ''
#arr = ['CREATE', 'READ', 'UPDATE', 'DELETE']
#record[:bit_crud].split(//).each_with_index do |val,ind|
#html << check_box_tag("record[checklist][]", val=='1', :id => "check_#{val}")
#html << "<label for='check_#{val}'>"
#html << "#{arr[ind]}"
#html << "</label>"
#end
#html
#format_column_checkbox(record, column)
end

      def code_search_column(record, input_name)
          select :record, :data_permission, DataPermission.find(:all).collect {|p| [ p.code, p.id ] }, :name => input_name
      end

      def crud_c_column(record)
         #return active_scaffold_column_checkbox(column, record.bit_crud),column
         #select(:record,:bit_crud,record[:bit_crud].split(//),:name=> input_name)
         #check_box_tag(column,record.crud_c,record.crud_c=="+")
         #check_box(record,update_crud,nil,record.crud_c=="+")
        if record.crud_c=="+"
          '1'
        else
          '0'
        end
      end

      def crud_c_form_column(record, name)
        logger.warn "#{Time.now.strftime("%H:%M:%S:%3N")} checklist_form_column record.bit_crud=#{record.bit_crud} #{record.class} record=#{record.inspect}"

         #return active_scaffold_column_checkbox(column, record.bit_crud),column
         #select(:record,:bit_crud,record[:bit_crud].split(//),:name=> input_name)
         #check_box(record.crud_c,ccrud_c_column,nil,'+','-')
         #check_box(column,nil,nil,record.crud_c=="+")
        select(:record,:bit_crud,record[:bit_crud].split(//)[0],:name=> name)
       end

      def ccrud_r_column(record, column)
        #return active_scaffold_column_checkbox(column, record.bit_crud),column
        #select(:record,:bit_crud,record[:bit_crud].split(//),:name=> input_name)
        check_box_tag(column, value = record.crud_r, checked = (record.crud_r=="+"))
      end

      def ccrud_u_column(record, column)
        #return active_scaffold_column_checkbox(column, record.bit_crud),column
        #select(:record,:bit_crud,record[:bit_crud].split(//),:name=> input_name)
        check_box_tag(column, value = record.crud_u, checked = (record.crud_u=="+"))
      end

      def ccrud_d_column(record, column)
        #return active_scaffold_column_checkbox(column, record.bit_crud),column
        #select(:record,:bit_crud,record[:bit_crud].split(//),:name=> input_name)
        check_box_tag(column, value = record.crud_d, checked = (record.crud_d=="+"))
      end

      def acreated_at_column(record, column)
        return record.created_at.strftime("%d.%m.%Y %H:%M:%S:%3N"),column
      end

      def acreated_at_form_column(record,name)
        record.created_at.strftime("%d.%m.%Y %H:%M:%S:%3N")
      end

      def group_present
        logger.warn "#{Time.now.strftime("%H:%M:%S:%3N")} group_present params[:group_id]=#{params[:group_id]}"
        grp=Group.find(:first,params[:group_id])
        "#{grp[:id]}-#{grp[:code]}"
      end

      def group_present_column(record, column)
        logger.warn "#{Time.now.strftime("%H:%M:%S:%3N")} HELPERs group_present_column record[:group_id]=#{record[:group_id]}"

        grp=Group.find(:first,record[:group_id])
        "#{grp[:id]}-#{grp[:code]}"
      end
#config.columns = [:name,  :gender ]
#config.columns[:bit_crud].form_ui = :radio
#config.columns[:bit_crud].options[:options] = [['Male', '1'], ['Female','2']]

    end



