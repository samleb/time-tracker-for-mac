require File.dirname(__FILE__) + '/spec_helper'

require "Application.bundle"
OSX::ns_import :TTDataSource

describe OSX::TTDataSource do
  
  before do
    DOCUMENT = OSX::TTDocument.alloc.init
    PROJECT_1 = OSX::TProject.alloc.init
    TASK_1_1 = mock("Task 1.1")
    TASK_1_2 = mock("Task 1.2")
    PROJECT_1.setTasks( [TASK_1_1, TASK_1_2] )
    DOCUMENT.setProjects( [PROJECT_1] )
  end

  it "should return the tree data for a project" do
    # Set up objects
    mockOutline = mock("NSOutlineView")
    ds = OSX::TTDataSource.alloc.init
    ds.setDocument( DOCUMENT )
    
    # Perform the test and assertations
    ds.outlineView_numberOfChildrenOfItem(mockOutline, PROJECT_1).should == 2
    ds.outlineView_child_ofItem(mockOutline, 0, PROJECT_1).should == TASK_1_1
    ds.outlineView_isItemExpandable(mockOutline, PROJECT_1).should be_true    
  end
  
end