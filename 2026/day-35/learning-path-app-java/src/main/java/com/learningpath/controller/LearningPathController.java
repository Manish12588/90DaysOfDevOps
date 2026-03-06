package com.learningpath.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.learningpath.model.LearningPath;
import com.learningpath.service.LearningPathService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Collection;

@Controller
public class LearningPathController {

    @Autowired
    private LearningPathService service;

    @Autowired
    private ObjectMapper objectMapper;

    @GetMapping("/")
    public String index(Model model) throws JsonProcessingException {
        Collection<LearningPath> paths = service.getAllPaths();
        model.addAttribute("paths", paths);
        model.addAttribute("pathsJson", objectMapper.writeValueAsString(paths));
        return "index";
    }

    @GetMapping("/api/paths")
    @ResponseBody
    public Collection<LearningPath> getAllPaths() {
        return service.getAllPaths();
    }

    @GetMapping("/api/paths/{id}")
    @ResponseBody
    public LearningPath getPath(@PathVariable String id) {
        return service.getPathById(id);
    }
}
