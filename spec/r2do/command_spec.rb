require 'spec_helper.rb'

class TestApp < R2do::App 
  def initialize(args)
    @args = args

    @file_name = ".r2do_test.yml"
    @state = load_state(@file_name)
    @commands = create_commands()
  end

  def calculate_path(file_name)
    data_path = File.expand_path(Dir.getwd)
    file_path = File.join(data_path, file_name)
  end
end



describe "Commands" do
  
  def create(arr)
    app = TestApp.new(arr)
    app.run
    app.save
    app
  end
  
  describe "initialize" do 
    before(:each) {
      Object.stub!(:puts)  
    }
    it "should initialize a new session if received `Y`" do
      R2do::UI.stub!(:input) { "Y" }
      Object.should_receive(:puts).with("Initialized a new session of r2do.")
      create(['i'])
    end 
    it "should continuing with current session if received `n`" do
      R2do::UI.stub!(:input) { "n" }
      Object.should_receive(:puts).with("Continuing with current session.")
      create(['i'])
    end
  end

  describe "category" do
    before(:each) do
      Object.stub!(:puts)
      R2do::UI.stub!(:input) { "Y" }
      create(['i'])
    end
    it "should create a new category" do
      Object.should_receive(:puts).with("Switched to new category 'Cat'")
      app = create(["c", "Cat"])
      
      state = app.instance_variable_get(:@state)
      state.current_category.name.should eq("Cat")
      state.categories.size.should eq(1)
    end

    it "should switched current category if new category created" do
      create(["c", "Cat"])
      app = create(["c", "NewCat"])
      
      state = app.instance_variable_get(:@state)
      state.current_category.name.should eq("NewCat")
      state.categories.size.should eq(2)
    end

    it "should display current category" do
      app = create(["c", "Current"])
      state = app.instance_variable_get(:@state)
      
      Object.should_receive(:puts).with(state.current_category.to_s)
      create(["c", "--display"])
    end

    it "should delete category" do
      create(["c", "Cat"])
      R2do::UI.stub!(:input) { "Y" }
      Object.should_receive(:puts).with("Category 'Cat' has been deleted.")
      create(['c', '--delete'])
    end

    it "should edit category" do
      create(["c", "Cat"])
      R2do::UI.stub!(:input).and_return('Y', 'Edit')
      app = create(['c', '--edit'])
      state = app.instance_variable_get(:@state)
      state.current_category.name.should eq("Edit")
    end

    it "should thrown error if command not found" do
      Object.should_receive(:puts).with("abort: R2do::InvalidOptionError")
      create(["c", "--z"])
    end
  end

  describe "task" do
    before(:each) do
      Object.stub!(:puts)
      R2do::UI.stub!(:input) { "Y" }
      create(['i'])
      @app = create(['c', 'Cat'])
    end

    it "should create a new task" do
      Object.should_receive(:puts).with("Selected task 'Task'")
      app = create(['t', 'Task'])
      state = app.instance_variable_get(:@state)
      state.current_category.current_task.description.should eq('Task')
      state.current_category.tasks.size.should eq(1)
    end

    it "should switched a new task if task created" do
      create(['t', 'Task'])
      Object.should_receive(:puts).with("Selected task 'NewTask'")
      app = create(['t', 'NewTask'])
      state = app.instance_variable_get(:@state)
      state.current_category.current_task.description.should eq('NewTask')
      state.current_category.tasks.size.should eq(2)
    end

    it "should display all tasks" do
      app = create(['t', 'SomeTask'])
      state = app.instance_variable_get(:@state)
      task = state.current_category.current_task
      Object.should_receive(:puts).with(/SomeTask/)
      create(['t', '--display'])      
    end

    it "should delete tasks" do
      create(["t", "Task"])
      R2do::UI.stub!(:input) { "Y" }
      Object.should_receive(:puts).with("Task 'Task' has been deleted.")
      create(['t', '--delete'])
    end

    it "should edit task" do
      create(["t", "Task"])
      R2do::UI.stub!(:input).and_return('Y', 'Edit')
      app = create(['t', '--edit'])
      state = app.instance_variable_get(:@state)
      state.current_category.current_task.description.should eq("Edit")
    end

    it "should marked task" do
      create(["t", "Task"])
      app = create(['t', '--done'])
      state = app.instance_variable_get(:@state)
      state.current_category.current_task.done?().should eq(true)
    end

    it "should return list all tasks in all categories" do
      create(['t', 'CatTasks1'])
      create(['t', 'CatTasks2'])
      create(['t', 'CatTasks3'])
      create(['c', 'NewCat'])
      create(['t', 'NewCatTasks1'])
      create(['t', 'NewCatTasks2'])
      Object.should_receive(:puts).with(/NewCatTasks1/)
      Object.should_receive(:puts).with(/NewCatTasks2/)
      Object.should_receive(:puts).with(/CatTasks1/)
      Object.should_receive(:puts).with(/CatTasks2/)
      Object.should_receive(:puts).with(/CatTasks3/)
      create(['t', '--all'])  
    end
    
    it "should thrown error if command not found" do
      Object.should_receive(:puts).with("abort: Invalid argument for the command. See 'r2do -h'.")
      create(["t", "--z"]) 
    end
  end

  describe "display" do
    before(:each) do
      Object.stub!(:puts)
      R2do::UI.stub!(:input) { "Y" }
      create(['i'])
    end

    it "should return 'No categories to display' if category not found" do
      Object.should_receive(:puts).with("No categories to display")
      create(['l'])
    end

    it "should display all categories" do
      create(['c', 'Cat1'])
      create(['c', 'Cat2'])
      Object.should_receive(:puts).with(/Cat1/)
      Object.should_receive(:puts).with(/Cat2/)
      create(['l'])
    end
  end

  describe "now" do
    it "should return tasks for current category" do
      Object.stub!(:puts)
      R2do::UI.stub!(:input) { "Y" }
      create(['i'])

      create(['c', 'Cat'])
      create(['t', 'Task1'])
      create(['t', 'Task2'])
      create(['t', 'Task3'])

      Object.should_receive(:puts).with(/Task1/)
      create(['now'])
    end
  end
end


