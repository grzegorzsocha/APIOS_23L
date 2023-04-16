//
//  main.swift
//  ćwiczenie_1_grzegorz_socha
//
//  Created by Grzegorz Socha on 14/03/2023.
//

import Foundation


class Node {
    var id: Int
    var data: Any
    var next: Node?
    
    init(id: Int, data: Any)
    {
        self.id = id
        self.data = data
        print("Node has been created")
    }
    
    deinit
    {
        print("Node has been deleted")
    }
    
    func add_next(next: Node)
    {
        self.next = next
    }
    
    func remove_next()
    {
        self.next = nil
    }
}

class Container
{
    var first: Node?
    var length: Int
    
    init()
    {
        self.length = 0
        print("Container has been created")
    }
    
    init(data: Any)
    {
        self.length = 1
        self.first = Node(id: self.length, data: data)
        print("Container has been created")
    }
    
    deinit
    {
        print("Container has been deleted")
    }
    
    func append(data: Any)
    {
        if (self.first == nil)
        {
            self.length += 1
            first = Node(id: self.length, data: data)
            
        }
        else if (self.first?.next == nil)
        {
            self.length += 1
            first?.next = Node(id: self.length, data: data)
            
        }
        else
        {
            var current = self.first?.next
            
            while let next = current?.next
            {
                current = next
            }
            
            self.length += 1
            current?.next = Node(id: self.length, data: data)
            
        }
    }
    
    func pop()
    {
        if (self.first?.next == nil)
        {
            first = nil
            self.length -= 1
        }
        else
        {
            var previous = self.first
            var current = self.first?.next
            
            
            while let next = current?.next
            {
                previous = current
                current = next
            }
            previous?.next = nil
            current = nil
        }
    }
}



var new_container = Container()
new_container.append(data: "jakies dane 1")
new_container.append(data: "jakies dane 2")
new_container.append(data: "jakies dane 3")

print(new_container.first?.data)
print(new_container.first?.next?.data)
print(new_container.first?.next?.next?.data)
new_container.pop()
print(new_container.first?.next?.next?.data	)
