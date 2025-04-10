//SPDX-License-Identifier: MANAS
pragma solidity ^0.8.0;

contract myToDoList {

    struct MyTask {
        string taskDescription;
        bool taskCompletionStatus; //true or false
        uint taskPriority;      //1 or 2 or 3
    }
    
    MyTask[] public myTasks;
    
    event TaskCreated(uint taskId, string taskDescription, uint taskPriority);
    event TaskCompleted(uint taskId, bool taskCompletionStatus);
    event TaskDeleted(uint taskId);

//add task
    function addTask(string memory description, uint priority) public {

        MyTask memory newTask = MyTask({
            taskDescription: description,
            taskCompletionStatus: false,
            taskPriority: priority
        });

        myTasks.push(newTask);

        emit TaskCreated(myTasks.length - 1, description, priority);
    }

//mark task as completed
    function markTaskCompleted(uint id) public {

        myTasks[id].taskCompletionStatus = true;

        emit TaskCompleted(id, true);
    }

//delete task
    function deleteTask(uint id) public {

        emit TaskDeleted(id);

        //moving task to last and pop
        myTasks[id] = myTasks[myTasks.length - 1];
        myTasks.pop();
    }

//update task description
    function updateTaskDescription(uint id, string memory description) public {

        myTasks[id].taskDescription = description;
    }

//update task priority
    function updateTaskPriority(uint id, uint priority) public {

        myTasks[id].taskPriority = priority;
    }

// Sort tasks by priority (highest to lowest priority)
    function sortTasksByPriority() public {
        for (uint i = 0; i < myTasks.length; i++) {
            for (uint j = i + 1; j < myTasks.length; j++) {
                //swap if needed
                if (myTasks[i].taskPriority < myTasks[j].taskPriority) {
                    MyTask memory temp = myTasks[i];
                    myTasks[i] = myTasks[j];
                    myTasks[j] = temp;
                }
            }
        }
    }

//get task by ID
    function getTask(uint id) public view returns (string memory, bool, uint) {

        MyTask memory task = myTasks[id];
        return (task.taskDescription, task.taskCompletionStatus, task.taskPriority);
    }

//get all tasks
    function getAllTasks() public view returns (MyTask[] memory) {
        return myTasks;
    }

//get Completed tasks
    function getCompletedTasks() public view returns (MyTask[] memory) {
        uint completedTaskCount = 0;
        
        for (uint i = 0; i < myTasks.length; i++) {
            if (myTasks[i].taskCompletionStatus) {
                completedTaskCount++;
            }
        }
        
        MyTask[] memory completedTasks = new MyTask[](completedTaskCount);
        uint index = 0;
        
        for (uint i = 0; i < myTasks.length; i++) {
            if (myTasks[i].taskCompletionStatus) {
                completedTasks[index] = myTasks[i];
                index++;
            }
        }
        
        return completedTasks;
    }

//get Pending tasks
    function getPendingTasks() public view returns (MyTask[] memory) {
        uint pendingTaskCount = 0;
        
        for (uint i = 0; i < myTasks.length; i++) {
            if (!myTasks[i].taskCompletionStatus) {
                pendingTaskCount++;
            }
        }
        
        MyTask[] memory pendingTasks = new MyTask[](pendingTaskCount);
        uint index = 0;
        
        for (uint i = 0; i < myTasks.length; i++) {
            if (!myTasks[i].taskCompletionStatus) {
                pendingTasks[index] = myTasks[i];
                index++;
            }
        }
        
        return pendingTasks;
    }

//get tasks by priority
    function getTasksByPriority(uint priority) public view returns (MyTask[] memory) {
        uint count = 0;
        
        for (uint i = 0; i < myTasks.length; i++) {
            if (myTasks[i].taskPriority == priority) {
                count++;
            }
        }
        
        MyTask[] memory priorityTasks = new MyTask[](count);
        uint index = 0;
        
        // Store tasks that match the priority in a new array
        for (uint i = 0; i < myTasks.length; i++) {
            if (myTasks[i].taskPriority == priority) {
                priorityTasks[index] = myTasks[i];
                index++;
            }
        }
        
        return priorityTasks;
    }


}
