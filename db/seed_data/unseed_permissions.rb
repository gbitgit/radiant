CtrlFilter.find(:all).map{|e| e.destroy}
CtrlPermission.find(:all).map{|e| e.destroy}

DataFilter.find(:all).map{|e| e.destroy}
DataPermission.find(:all).map{|e| e.destroy}
