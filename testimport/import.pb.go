// Code generated by protoc-gen-gogo.
// source: import.proto
// DO NOT EDIT!

/*
Package testimport is a generated protocol buffer package.

It is generated from these files:
	import.proto

It has these top-level messages:
*/
package testimport

import proto "github.com/gogo/protobuf/proto"
import fmt "fmt"
import math "math"
import serve "github.com/gogo/letmegrpc/letmetestserver/serve"

import (
	context "golang.org/x/net/context"
	grpc "google.golang.org/grpc"
)

// Reference imports to suppress errors if they are not otherwise used.
var _ = proto.Marshal
var _ = fmt.Errorf
var _ = math.Inf

// Reference imports to suppress errors if they are not otherwise used.
var _ context.Context
var _ grpc.ClientConn

// Client API for OtherLabel service

type OtherLabelClient interface {
	Produce(ctx context.Context, in *serve.Album, opts ...grpc.CallOption) (*serve.Album, error)
}

type otherLabelClient struct {
	cc *grpc.ClientConn
}

func NewOtherLabelClient(cc *grpc.ClientConn) OtherLabelClient {
	return &otherLabelClient{cc}
}

func (c *otherLabelClient) Produce(ctx context.Context, in *serve.Album, opts ...grpc.CallOption) (*serve.Album, error) {
	out := new(serve.Album)
	err := grpc.Invoke(ctx, "/testimport.OtherLabel/Produce", in, out, c.cc, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// Server API for OtherLabel service

type OtherLabelServer interface {
	Produce(context.Context, *serve.Album) (*serve.Album, error)
}

func RegisterOtherLabelServer(s *grpc.Server, srv OtherLabelServer) {
	s.RegisterService(&_OtherLabel_serviceDesc, srv)
}

func _OtherLabel_Produce_Handler(srv interface{}, ctx context.Context, codec grpc.Codec, buf []byte) (interface{}, error) {
	in := new(serve.Album)
	if err := codec.Unmarshal(buf, in); err != nil {
		return nil, err
	}
	out, err := srv.(OtherLabelServer).Produce(ctx, in)
	if err != nil {
		return nil, err
	}
	return out, nil
}

var _OtherLabel_serviceDesc = grpc.ServiceDesc{
	ServiceName: "testimport.OtherLabel",
	HandlerType: (*OtherLabelServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "Produce",
			Handler:    _OtherLabel_Produce_Handler,
		},
	},
	Streams: []grpc.StreamDesc{},
}
